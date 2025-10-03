import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_counts_model.freezed.dart';
part 'badge_counts_model.g.dart';

@freezed
class BadgeCountsModel with _$BadgeCountsModel {
  const factory BadgeCountsModel({
    required int bronze,
    required int silver,
    required int gold,
  }) = _BadgeCountsModel;

  factory BadgeCountsModel.fromJson(Map<String, dynamic> json) =>
      _$BadgeCountsModelFromJson(json);
}
