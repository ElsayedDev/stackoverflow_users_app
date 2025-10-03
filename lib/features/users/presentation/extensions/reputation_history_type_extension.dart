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
}
