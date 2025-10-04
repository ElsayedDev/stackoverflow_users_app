import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/types/aliases.dart';
import 'package:stackoverflow_users_app/core/utils/paginated_fetch_mixin.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_users.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/toggle_bookmark.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/watch_bookmarks.dart';
import 'package:stackoverflow_users_app/features/users/presentation/models/user_ui.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> with PaginatedFetchMixin {
  final GetUsers _getUsers;
  final WatchBookmarks _watchBookmarks;
  final ToggleBookmark _toggleBookmark;

  StreamSubscription<EitherFailure<Set<int>>>? _bookmarkSubscription;

  UsersCubit(
    this._getUsers,
    this._watchBookmarks,
    this._toggleBookmark,
  ) : super(UsersState.initial()) {
    _onInit();
  }

  Future<void> onLoadInit({bool force = false}) async {
    if (!force && state.users.isNotEmpty) return;
    if (!beginFetch(resetPage: true)) return;

    emit(state.copyWith(
      isLoading: true,
      hasMore: true,
      clearError: true,
    ));

    final response = await _getUsers(const GetUsersParams(page: 1));
    response.fold(
      (failure) {
        completeFetchFailure();
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (data) {
        final users = _mapToUi(data.items);
        completeFetchSuccess(1);
        emit(state.copyWith(
          users: users,
          hasMore: data.hasMore,
          isLoading: false,
          clearError: true,
        ));
      },
    );
  }

  Future<void> onLoadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    if (!beginFetch()) return;

    final nextPage = currentPage + 1;
    emit(state.copyWith(isLoadingMore: true));

    final response = await _getUsers(GetUsersParams(page: nextPage));
    response.fold(
      (failure) {
        completeFetchFailure();
        emit(state.copyWith(isLoadingMore: false, error: failure.message));
      },
      (data) {
        final users = _mapToUi(data.items);
        completeFetchSuccess(nextPage);
        emit(state.copyWith(
          users: [...state.users, ...users],
          hasMore: data.hasMore,
          isLoadingMore: false,
          clearError: true,
        ));
      },
    );
  }

  Future<void> onRefresh() async => onLoadInit(force: true);

  /// Optimistic toggle: update immediately, rollback on failure
  Future<void> onToggleBookmark(int userId) async {
    final prev = state._bookmarkedIds;
    final next = Set<int>.from(prev);
    if (!next.add(userId)) next.remove(userId);

    emit(state.copyWith(bookmarksIds: next));
    _recomputeFast(bookmarkedIds: next);

    final res = await _toggleBookmark(ToggleBookmarkParams(userId: userId));
    res.fold(
      (failure) {
        emit(state.copyWith(error: failure.message, bookmarksIds: prev));
        _recomputeFast(bookmarkedIds: prev);
      },
      (_) {},
    );
  }

  // ---- private ----

  void _onInit() {
    _bookmarkSubscription?.cancel();
    _bookmarkSubscription = _watchBookmarks()
        .distinct() // avoid redundant emits
        .listen((event) {
      event.fold(
        (failure) => emit(state.copyWith(error: failure.message)),
        (bookmarks) {
          emit(state.copyWith(bookmarksIds: {...bookmarks}));
          _recompute();
        },
      );
    });
  }

  List<UserUi> _mapToUi(List<UserEntity> entities) {
    final ids = state._bookmarkedIds;
    return entities
        .map((e) => UserUi(user: e, isBookmarked: ids.contains(e.id)))
        .toList(growable: false);
  }

  /// Fast recompute in same isolate for normal list sizes
  void _recomputeFast({Set<int>? bookmarkedIds}) {
    final ids = bookmarkedIds ?? state._bookmarkedIds;
    final updated = List<UserUi>.generate(
      state.users.length,
      (i) {
        final u = state.users[i];
        final isBm = ids.contains(u.user.id);
        return u.isBookmarked == isBm ? u : u.copyWith(isBookmarked: isBm);
      },
      growable: false,
    );
    emit(state.copyWith(users: updated));
  }

  /// Heavy recompute fallback for very large lists
  Future<void> _recompute() async {
    if (state.users.length < 400) {
      _recomputeFast();
      return;
    }
    final recomputed = await compute(
      (args) {
        final users = args[0] as List<UserUi>;
        final ids = args[1] as Set<int>;
        return users
            .map((u) => u.copyWith(isBookmarked: ids.contains(u.user.id)))
            .toList(growable: false);
      },
      [state.users, state._bookmarkedIds],
    );
    emit(state.copyWith(users: recomputed));
  }

  @override
  Future<void> close() async {
    await _bookmarkSubscription?.cancel();
    return super.close();
  }
}
