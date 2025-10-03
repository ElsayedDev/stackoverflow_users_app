import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stackoverflow_users_app/features/users/data/models/badge_counts_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'account_id') required int accountId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'profile_image') required String profileImage,
    required int reputation,
    String? location,
    @JsonKey(name: 'badge_counts') required BadgeCountsModel badgeCounts,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
