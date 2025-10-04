part of 'reputation_cubit.dart';

class ReputationState extends Equatable {
  final List<ReputationEntity> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final int? userId;
  final UserEntity? user;
  final bool isUserLoading;
  final String? userError;

  const ReputationState({
    this.items = const <ReputationEntity>[],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.userId,
    this.user,
    this.isUserLoading = false,
    this.userError,
  });

  bool get showInitialLoader => isLoading && items.isEmpty;
  bool get showInitialError => error != null && items.isEmpty;
  bool get showEmptyState => !isLoading && items.isEmpty && error == null;

  // States
  factory ReputationState.initial() => const ReputationState();

  ReputationState copyWith({
    List<ReputationEntity>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    bool clearError = false,
    int? userId,
    UserEntity? user,
    bool? isUserLoading,
    String? userError,
    bool clearUserError = false,
  }) {
    return ReputationState(
      items: List<ReputationEntity>.unmodifiable(items ?? this.items),
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: clearError ? null : (error ?? this.error),
      userId: userId ?? this.userId,
      user: user ?? this.user,
      isUserLoading: isUserLoading ?? this.isUserLoading,
      userError: clearUserError ? null : (userError ?? this.userError),
    );
  }

  @override
  List<Object?> get props => [
        items,
        isLoading,
        isLoadingMore,
        hasMore,
        error,
        userId,
        user,
        isUserLoading,
        userError,
      ];
}
