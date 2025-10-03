import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._repository) : super(UsersState()) {
    _hydrateBookmarks();
  }

  final UsersRepository _repository;
  int _currentPage = 0;
  bool _isFetching = false;
  StreamSubscription<Either<Failure, Set<int>>>? _bookmarkSubscription;

  Future<void> _hydrateBookmarks() async {
    final initial = _repository.getBookmarksOnce();
    initial.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (bookmarks) => emit(state.copyWith(
        bookmarks: bookmarks,
        clearError: true,
      )),
    );

    _bookmarkSubscription = _repository.watchBookmarks().listen((event) {
      event.fold(
        (failure) => emit(state.copyWith(error: failure.message)),
        (bookmarks) => emit(state.copyWith(
          bookmarks: bookmarks,
          clearError: true,
        )),
      );
    });
  }

  Future<void> loadInitial({bool force = false}) async {
    if (_isFetching) return;
    if (!force && state.users.isNotEmpty) return;

    _isFetching = true;
    emit(state.copyWith(
      isLoading: true,
      hasMore: true,
      clearError: true,
    ));

    final response = await _repository.getUsers(1);
    response.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        ));
      },
      (data) {
        final (users, hasMore) = data;
        _currentPage = 1;
        emit(state.copyWith(
          users: users,
          hasMore: hasMore,
          isLoading: false,
          clearError: true,
        ));
      },
    );

    _isFetching = false;
  }

  Future<void> loadMore() async {
    if (_isFetching || !state.hasMore || state.isLoadingMore) return;
    _isFetching = true;
    emit(state.copyWith(isLoadingMore: true));

    final nextPage = _currentPage + 1;
    final response = await _repository.getUsers(nextPage);
    response.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingMore: false,
          error: failure.message,
        ));
        _isFetching = false;
      },
      (data) {
        final (users, hasMore) = data;
        _currentPage = nextPage;
        emit(state.copyWith(
          users: [...state.users, ...users],
          hasMore: hasMore,
          isLoadingMore: false,
          clearError: true,
        ));
        _isFetching = false;
      },
    );
  }

  Future<void> refresh() async {
    await loadInitial(force: true);
  }

  Future<void> toggleBookmark(int userId) async {
    final response = await _repository.toggleBookmark(userId);
    response.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) {},
    );
  }

  void setBookmarksFilter(bool showOnly) {
    if (state.showBookmarksOnly == showOnly) return;
    emit(state.copyWith(showBookmarksOnly: showOnly));
  }

  void toggleBookmarksFilter() {
    emit(state.copyWith(showBookmarksOnly: !state.showBookmarksOnly));
  }

  @override
  Future<void> close() async {
    await _bookmarkSubscription?.cancel();
    await super.close();
  }
}
