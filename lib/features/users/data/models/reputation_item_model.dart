import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stackoverflow_users_app/features/users/data/models/reputation_history_type_model.dart';

part 'reputation_item_model.freezed.dart';
part 'reputation_item_model.g.dart';

@freezed
class ReputationItemModel with _$ReputationItemModel {
  const factory ReputationItemModel({
    @JsonKey(name: 'reputation_history_type')
    required ReputationHistoryTypeModel reputationHistoryType,
    @JsonKey(name: 'reputation_change') required int reputationChange,
    @JsonKey(name: 'post_id') required int postId,
    @JsonKey(name: 'creation_date') required int creationDate,
    @JsonKey(name: 'user_id') required int userId,
  }) = _ReputationItemModel;

  factory ReputationItemModel.fromJson(Map<String, dynamic> json) =>
      _$ReputationItemModelFromJson(json);
}
