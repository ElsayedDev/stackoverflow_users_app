import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_history_type.dart';

extension ReputationHistoryTypeX on ReputationHistoryType {
  bool get isPositive => <ReputationHistoryType>{
        ReputationHistoryType.postUpvoted,
        ReputationHistoryType.answerAccepted,
        ReputationHistoryType.bountyEarned,
        ReputationHistoryType.associationBonus,
        ReputationHistoryType.suggestedEditApprovalReceived,
        ReputationHistoryType.exampleUpvoted,
        ReputationHistoryType.docLinkUpvoted,
        ReputationHistoryType.proposedChangeApproved,
      }.contains(this);

  String get label {
    final raw = name.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );

    final normalized = raw.replaceAll('_', ' ').trim();
    final words =
        normalized.split(RegExp(r'\s+')).where((word) => word.isNotEmpty);
    return words
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
