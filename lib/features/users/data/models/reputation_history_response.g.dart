// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reputation_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReputationHistoryResponseImpl _$$ReputationHistoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReputationHistoryResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => ReputationItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['has_more'] as bool,
      quotaMax: (json['quota_max'] as num).toInt(),
      quotaRemaining: (json['quota_remaining'] as num).toInt(),
    );

Map<String, dynamic> _$$ReputationHistoryResponseImplToJson(
        _$ReputationHistoryResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'has_more': instance.hasMore,
      'quota_max': instance.quotaMax,
      'quota_remaining': instance.quotaRemaining,
    };
