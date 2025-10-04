import 'package:equatable/equatable.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';

final class UserUi extends Equatable {
  final UserEntity user;
  final bool isBookmarked;

  const UserUi({
    required this.user,
    required this.isBookmarked,
  });

  int get id => user.id;

  UserUi copyWith({
    UserEntity? user,
    bool? isBookmarked,
  }) =>
      UserUi(
        user: user ?? this.user,
        isBookmarked: isBookmarked ?? this.isBookmarked,
      );

  @override
  List<Object?> get props => [user, isBookmarked];
}
