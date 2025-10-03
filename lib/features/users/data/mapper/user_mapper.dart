import 'package:stackoverflow_users_app/features/users/data/mapper/badge_counts_mapper.dart';
import 'package:stackoverflow_users_app/features/users/data/models/user_model.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';

extension UserMapper on UserModel {
  UserEntity toEntity() => UserEntity(
        id: userId,
        name: displayName,
        avatar: profileImage,
        reputation: reputation,
        location: location,
        badgeCounts: badgeCounts.toEntity(),
      );
}
