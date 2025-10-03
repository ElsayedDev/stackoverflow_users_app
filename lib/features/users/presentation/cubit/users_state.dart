import 'package:equatable/equatable.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';

class UsersState extends Equatable {
  UsersState({
    List<UserEntity> users = const <UserEntity>[],
    Set<int> bookmarks = const <int>{},
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.showBookmarksOnly = false,
  })  : users = List<UserEntity>.unmodifiable(users),
        bookmarks = Set<int>.unmodifiable(bookmarks);

  final List<UserEntity> users;
  final Set<int> bookmarks;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final bool showBookmarksOnly;

  bool get showInitialLoader => isLoading && users.isEmpty;
  bool get showInitialError => error != null && users.isEmpty;

  UsersState copyWith({
    List<UserEntity>? users,
    Set<int>? bookmarks,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    bool? showBookmarksOnly,
    bool clearError = false,
  }) {
    return UsersState(
      users: users ?? this.users,
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      showBookmarksOnly: showBookmarksOnly ?? this.showBookmarksOnly,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [
        users,
        bookmarks,
        isLoading,
        isLoadingMore,
        hasMore,
        error,
        showBookmarksOnly,
      ];
}
