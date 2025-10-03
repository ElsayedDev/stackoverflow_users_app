import 'package:equatable/equatable.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';

class ReputationState extends Equatable {
  const ReputationState({
    this.items = const <ReputationEntity>[],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
  });

  final List<ReputationEntity> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;

  bool get showInitialLoader => isLoading && items.isEmpty;
  bool get showInitialError => error != null && items.isEmpty;
  bool get showEmptyState => !isLoading && items.isEmpty && error == null;

  ReputationState copyWith({
    List<ReputationEntity>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    bool clearError = false,
  }) {
    return ReputationState(
      items: List<ReputationEntity>.unmodifiable(items ?? this.items),
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [items, isLoading, isLoadingMore, hasMore, error];
}
