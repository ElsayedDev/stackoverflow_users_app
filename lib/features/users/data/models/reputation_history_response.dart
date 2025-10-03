import 'package:freezed_annotation/freezed_annotation.dart';
import 'reputation_item_model.dart';

part 'reputation_history_response.freezed.dart';
part 'reputation_history_response.g.dart';

@freezed
class ReputationHistoryResponse with _$ReputationHistoryResponse {
  const factory ReputationHistoryResponse({
    required List<ReputationItemModel> items,
    @JsonKey(name: 'has_more') required bool hasMore,
    @JsonKey(name: 'quota_max') required int quotaMax,
    @JsonKey(name: 'quota_remaining') required int quotaRemaining,
  }) = _ReputationHistoryResponse;

  factory ReputationHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ReputationHistoryResponseFromJson(json);
}
