part of 'users_cubit.dart';

class UsersState extends Equatable {
  final List<UserUi> _users;
  final Set<int> _bookmarkedIds;

  final bool _isLoading;
  final bool _isLoadingMore;
  final bool _hasMore;
  final String? _error;

  const UsersState({
    List<UserUi> users = const <UserUi>[],
    Set<int> bookmarkedIds = const <int>{},
    bool isLoading = false,
    bool isLoadingMore = false,
    bool hasMore = true,
    String? error,
  })  : _users = users,
        _isLoading = isLoading,
        _isLoadingMore = isLoadingMore,
        _hasMore = hasMore,
        _error = error,
        _bookmarkedIds = bookmarkedIds;

  List<UserUi> get users => [..._users];

  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  String? get error => _error;
  bool get showInitialLoader => isLoading && users.isEmpty;
  bool get showInitialError => error != null && users.isEmpty;

  /// States
  ///
  /// Represents the various states of the user feature.
  factory UsersState.initial() => const UsersState();

  UsersState copyWith({
    List<UserUi>? users,
    Set<int>? bookmarksIds,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    bool clearError = false,
  }) =>
      UsersState(
        users: users ?? _users,
        bookmarkedIds: bookmarksIds ?? _bookmarkedIds,
        isLoading: isLoading ?? _isLoading,
        isLoadingMore: isLoadingMore ?? _isLoadingMore,
        hasMore: hasMore ?? _hasMore,
        error: clearError ? null : (error ?? _error),
      );

  @override
  List<Object?> get props => [
        _users,
        _bookmarkedIds,
        _isLoading,
        _isLoadingMore,
        _hasMore,
        _error,
      ];
}
