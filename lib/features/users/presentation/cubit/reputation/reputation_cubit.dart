import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/utils/paginated_fetch_mixin.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_reputation.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_user_by_id.dart';

part 'reputation_state.dart';

class ReputationCubit extends Cubit<ReputationState> with PaginatedFetchMixin {
  ReputationCubit(
    this._getReputation,
    this._getUserById,
  ) : super(ReputationState.initial());

  final GetReputation _getReputation;
  final GetUserById _getUserById;

  Future<void> onInit(int userId) async {
    completeFetchSuccess(0);
    emit(state.copyWith(
      userId: userId,
      isUserLoading: true,
      clearUserError: true,
    ));

    final result = await _getUserById(GetUserByIdParams(userId: userId));
    result.fold(
      (failure) => emit(state.copyWith(
        isUserLoading: false,
        userError: failure.message,
      )),
      (user) => emit(state.copyWith(
        user: user,
        isUserLoading: false,
        clearUserError: true,
      )),
    );
  }

  Future<void> onLoadInit({bool force = false}) async {
    final userId = state.userId;
    if (userId == null) return;

    if (!force && state.items.isNotEmpty) return;
    if (!beginFetch(resetPage: true)) return;

    emit(state.copyWith(
      isLoading: true,
      hasMore: true,
      clearError: true,
      items: const <ReputationEntity>[],
    ));

    final response =
        await _getReputation(GetReputationParams(userId: userId, page: 1));
    response.fold(
      (failure) {
        completeFetchFailure();
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        ));
      },
      (data) {
        final items = data.items;
        final hasMore = data.hasMore;
        completeFetchSuccess(1);
        emit(state.copyWith(
          items: items,
          hasMore: hasMore,
          isLoading: false,
          clearError: true,
        ));
      },
    );
  }

  Future<void> onLoadMore() async {
    final userId = state.userId;
    if (userId == null) return;

    if (!state.hasMore || state.isLoadingMore) return;
    if (!beginFetch()) return;
    emit(state.copyWith(isLoadingMore: true));

    final nextPage = currentPage + 1;
    final response = await _getReputation(
      GetReputationParams(userId: userId, page: nextPage),
    );
    response.fold(
      (failure) {
        completeFetchFailure();
        emit(state.copyWith(
          isLoadingMore: false,
          error: failure.message,
        ));
      },
      (data) {
        final items = data.items;
        final hasMore = data.hasMore;
        completeFetchSuccess(nextPage);
        emit(state.copyWith(
          items: [...state.items, ...items],
          hasMore: hasMore,
          isLoadingMore: false,
          clearError: true,
        ));
      },
    );
  }

  Future<void> onRefresh() async => await onLoadInit(force: true);
}
