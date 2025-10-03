import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_history_type.dart';

class ReputationEntity {
  final ReputationHistoryType type;
  final int change;
  final int postId;
  final DateTime createdAt;

  const ReputationEntity({
    required this.type,
    required this.change,
    required this.postId,
    required this.createdAt,
  });
}
