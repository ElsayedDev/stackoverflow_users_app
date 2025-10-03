// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      accountId: (json['account_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      displayName: json['display_name'] as String,
      profileImage: json['profile_image'] as String,
      reputation: (json['reputation'] as num).toInt(),
      location: json['location'] as String?,
      badgeCounts: BadgeCountsModel.fromJson(
          json['badge_counts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'user_id': instance.userId,
      'display_name': instance.displayName,
      'profile_image': instance.profileImage,
      'reputation': instance.reputation,
      'location': instance.location,
      'badge_counts': instance.badgeCounts,
    };
