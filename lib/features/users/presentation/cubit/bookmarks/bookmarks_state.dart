part of 'bookmarks_cubit.dart';

class BookmarksState extends Equatable {
  const BookmarksState({
    Set<int> bookmarks = const <int>{},
    List<UserEntity> users = const <UserEntity>[],
    bool isLoading = false,
    bool isLoadingMore = false,
    bool hasMore = false,
    String? error,
  })  : _bookmarksIds = bookmarks,
        _users = users,
        _isLoading = isLoading,
        _isLoadingMore = isLoadingMore,
        _hasMore = hasMore,
        _error = error;

  final Set<int> _bookmarksIds;
  final List<UserEntity> _users;
  final bool _isLoading;
  final bool _isLoadingMore;
  final bool _hasMore;
  final String? _error;

  List<UserEntity> get users => [..._users];
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;
  String? get error => _error;

  bool get showInitialLoader => _isLoading && _users.isEmpty;
  bool get showInitialError => _error != null && _users.isEmpty;

  factory BookmarksState.initial() => const BookmarksState();

  BookmarksState copyWith({
    Set<int>? bookmarksIds,
    List<UserEntity>? users,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    bool clearError = false,
  }) =>
      BookmarksState(
        bookmarks: bookmarksIds ?? _bookmarksIds,
        users: users ?? _users,
        isLoading: isLoading ?? _isLoading,
        isLoadingMore: isLoadingMore ?? _isLoadingMore,
        hasMore: hasMore ?? _hasMore,
        error: clearError ? null : (error ?? _error),
      );

  @override
  List<Object?> get props => [
        _bookmarksIds,
        _users,
        _isLoading,
        _isLoadingMore,
        _hasMore,
        _error,
      ];
}
