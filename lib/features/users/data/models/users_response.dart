import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'users_response.freezed.dart';
part 'users_response.g.dart';

@freezed
class UsersResponse with _$UsersResponse {
  const factory UsersResponse({
    required List<UserModel> items,
    required bool hasMore,
    required int quotaMax,
    required int quotaRemaining,
  }) = _UsersResponse;

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);
}
