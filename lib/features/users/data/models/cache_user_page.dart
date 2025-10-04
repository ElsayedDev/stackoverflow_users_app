import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stackoverflow_users_app/core/utils/map_extensions.dart';
import 'package:stackoverflow_users_app/features/users/data/models/user_model.dart';

part 'cache_user_page.freezed.dart';
part 'cache_user_page.g.dart';

@freezed
class CacheUserPage with _$CacheUserPage {
  const factory CacheUserPage({
    required int page,
    @JsonKey(name: 'has_more') required bool hasMore,
    required List<UserModel> users,
  }) = _CacheUserPage;

  factory CacheUserPage.fromJson(Map<String, dynamic> json) =>
      _$CacheUserPageFromJson(_normalizeJson(json));
}

Map<String, dynamic> _normalizeJson(Map<String, dynamic> source) {
  final normalized = Map<String, dynamic>.from(source);

  if (!normalized.containsKey('has_more') &&
      normalized.containsKey('hasMore')) {
    normalized['has_more'] = normalized['hasMore'];
  }

  final users = normalized['users'];
  if (users is List) {
    normalized['users'] = users
        .whereType<Map>()
        .map(
            (raw) => raw is Map<String, dynamic> ? raw : raw.toStringKeyedMap())
        .toList(growable: false);
  } else {
    normalized['users'] = const <Map<String, dynamic>>[];
  }

  return normalized;
}
