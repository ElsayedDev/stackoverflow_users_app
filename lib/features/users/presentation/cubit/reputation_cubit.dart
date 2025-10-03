import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation_state.dart';

class ReputationCubit extends Cubit<ReputationState> {
  final UsersRepository _repository;

  ReputationCubit(this._repository) : super(const ReputationState());

  final int userId = 0;

  int _currentPage = 0;
  bool _isFetching = false;

  Future<void> loadInitial({bool force = false}) async {
    if (_isFetching) return;
    if (!force && state.items.isNotEmpty) return;

    _isFetching = true;
    emit(state.copyWith(
      isLoading: true,
      hasMore: true,
      clearError: true,
      items: const <ReputationEntity>[],
    ));

    final response = await _repository.getReputation(userId, 1);
    response.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        ));
      },
      (data) {
        final (items, hasMore) = data;
        _currentPage = 1;
        emit(state.copyWith(
          items: items,
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
    final response = await _repository.getReputation(userId, nextPage);
    response.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingMore: false,
          error: failure.message,
        ));
        _isFetching = false;
      },
      (data) {
        final (items, hasMore) = data;
        _currentPage = nextPage;
        emit(state.copyWith(
          items: [...state.items, ...items],
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
}
