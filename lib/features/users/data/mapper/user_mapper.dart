import 'package:html_unescape/html_unescape.dart';
import 'package:stackoverflow_users_app/features/users/data/mapper/badge_counts_mapper.dart';
import 'package:stackoverflow_users_app/features/users/data/models/user_model.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';

final _unescape = HtmlUnescape();

extension UserMapper on UserModel {
  UserEntity toEntity() => UserEntity(
        id: userId,
        name: _unescape.convert(displayName),
        avatar: profileImage,
        reputation: reputation,
        location: location == null ? null : _unescape.convert(location!),
        badgeCounts: badgeCounts.toEntity(),
      );
}
