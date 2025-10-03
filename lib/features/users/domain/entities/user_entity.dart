import 'package:stackoverflow_users_app/features/users/domain/entities/badge_counts.dart';

class UserEntity {
  final int id;
  final String name;
  final String avatar;
  final int reputation;
  final String? location;
  final BadgeCounts badgeCounts;

  const UserEntity({
    required this.id,
    required this.name,
    required this.avatar,
    required this.reputation,
    required this.badgeCounts,
    this.location,
  });
}
