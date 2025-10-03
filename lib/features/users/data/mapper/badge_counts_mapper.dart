import 'package:stackoverflow_users_app/features/users/data/models/badge_counts_model.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/badge_counts.dart';

extension BadgeCountsMapper on BadgeCountsModel {
  BadgeCounts toEntity() => BadgeCounts(
        gold: gold,
        silver: silver,
        bronze: bronze,
      );
}
