import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/types/aliases.dart';
import 'package:stackoverflow_users_app/core/utils/paginated_fetch_mixin.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_users_by_ids.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/toggle_bookmark.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/watch_bookmarks.dart';
part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> with PaginatedFetchMixin {
  BookmarksCubit({
    required GetUsersByIds getUsersByIds,
    required ToggleBookmark toggleBookmark,
    required WatchBookmarks watchBookmarks,
    int pageSize = 20,
  })  : _getUsersByIds = getUsersByIds,
        _toggleBookmark = toggleBookmark,
        _watchBookmarks = watchBookmarks,
        _pageSize = pageSize,
        super(BookmarksState.initial()) {
    _hydrateBookmarks();
  }

  final GetUsersByIds _getUsersByIds;
  final ToggleBookmark _toggleBookmark;
  final WatchBookmarks _watchBookmarks;
  final int _pageSize;

  StreamSubscription<EitherFailure<Set<int>>>? _bookmarkSubscription;

  // --- Helpers ---
  List<int> _orderedIds() => state._bookmarksIds.toList()
    ..sort(); // or preserve insertion order from local DS

  void _hydrateBookmarks() {
    _bookmarkSubscription?.cancel();
    _bookmarkSubscription = _watchBookmarks().listen((event) {
      event.fold(
        (failure) => emit(state.copyWith(error: failure.message)),
        (bookmarksIds) async {
          // Optionally keep currently visible users that are still bookmarked to avoid flicker
          final ids = bookmarksIds;
          final filtered = state.users
              .where((u) => ids.contains(u.id))
              .toList(growable: false);

          emit(state.copyWith(
            bookmarksIds: {...bookmarksIds},
            users: filtered,
            // hasMore recalculated below on load
            clearError: true,
          ));

          // Reload first page to reflect new ordering/ids
          await onLoadInit(force: true);
        },
      );
    });
  }

  Future<void> onLoadInit({bool force = false}) async {
    final ids = _orderedIds();
    if (ids.isEmpty) {
      emit(state.copyWith(
        users: const <UserEntity>[],
        isLoading: false,
        isLoadingMore: false,
        hasMore: false,
        clearError: true,
      ));
      return;
    }

    if (!force && state.users.isNotEmpty) return;
    if (!beginFetch(resetPage: true)) return;

    emit(state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      hasMore: ids.isNotEmpty,
      users: const <UserEntity>[],
      clearError: true,
    ));

    final result = await _fetchUsersChunk(startIndex: 0, count: _pageSize);

    result.fold(
      (failure) {
        completeFetchFailure();
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (data) {
        final users = List<UserEntity>.unmodifiable(data);
        final hasMore = users.length < ids.length;
        completeFetchSuccess(1); // keep pages 1-based
        emit(state.copyWith(
          users: users,
          hasMore: hasMore,
          isLoading: false,
          clearError: true,
        ));
      },
    );
  }

  Future<void> onLoadMore() async {
    final ids = _orderedIds();
    if (ids.isEmpty) return;
    if (!state.hasMore || state.isLoadingMore) return;
    if (!beginFetch()) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _fetchUsersChunk(
      startIndex: state.users.length,
      count: _pageSize,
    );

    result.fold(
      (failure) {
        completeFetchFailure();
        emit(state.copyWith(isLoadingMore: false, error: failure.message));
      },
      (data) {
        // Merge, dedupe by id
        final merged = List<UserEntity>.from(state.users);
        final seen = merged.map((u) => u.id).toSet();
        for (final u in data) {
          if (seen.add(u.id)) merged.add(u);
        }

        final hasMore = merged.length < ids.length;
        final nextPage = hasMore ? currentPage + 1 : currentPage;
        completeFetchSuccess(nextPage);

        emit(state.copyWith(
          users: List<UserEntity>.unmodifiable(merged),
          hasMore: hasMore,
          isLoadingMore: false,
          clearError: true,
        ));
      },
    );
  }

  Future<void> onRefresh() => onLoadInit(force: true);

  Future<void> onToggleBookmark(int userId) async {
    final response =
        await _toggleBookmark(ToggleBookmarkParams(userId: userId));
    response.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) {},
    );
  }

  Future<EitherFailure<List<UserEntity>>> _fetchUsersChunk({
    required int startIndex,
    required int count,
  }) async {
    final orderedIds = _orderedIds();
    if (orderedIds.isEmpty) return const Right(<UserEntity>[]);

    // Slice requested IDs (stable order)
    final slice =
        orderedIds.skip(startIndex).take(count).toList(growable: false);
    if (slice.isEmpty) return const Right(<UserEntity>[]);

    // Fetch batch
    final res = await _getUsersByIds(GetUsersByIdsParams(ids: slice));

    // Reorder returned users to match requested order, and (optionally) backfill missing by pulling next IDs
    return res.map((users) {
      final byId = {for (final u in users) u.id: u};
      final ordered = <UserEntity>[];

      for (final id in slice) {
        final u = byId[id];
        if (u != null) ordered.add(u);
      }

      return List<UserEntity>.unmodifiable(ordered);
    });
  }

  @override
  Future<void> close() async {
    await _bookmarkSubscription?.cancel();
    return super.close();
  }
}
