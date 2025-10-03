// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_counts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BadgeCountsModelImpl _$$BadgeCountsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BadgeCountsModelImpl(
      bronze: (json['bronze'] as num).toInt(),
      silver: (json['silver'] as num).toInt(),
      gold: (json['gold'] as num).toInt(),
    );

Map<String, dynamic> _$$BadgeCountsModelImplToJson(
        _$BadgeCountsModelImpl instance) =>
    <String, dynamic>{
      'bronze': instance.bronze,
      'silver': instance.silver,
      'gold': instance.gold,
    };
