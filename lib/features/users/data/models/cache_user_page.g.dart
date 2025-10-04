// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_user_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CacheUserPageImpl _$$CacheUserPageImplFromJson(Map<String, dynamic> json) =>
    _$CacheUserPageImpl(
      page: (json['page'] as num).toInt(),
      hasMore: json['has_more'] as bool,
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CacheUserPageImplToJson(_$CacheUserPageImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'has_more': instance.hasMore,
      'users': instance.users,
    };
