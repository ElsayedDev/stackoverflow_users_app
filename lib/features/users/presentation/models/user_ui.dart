import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';

class UserUi {
  final UserEntity user;
  final bool isBookmarked;

  const UserUi({
    required this.user,
    required this.isBookmarked,
  });
}
