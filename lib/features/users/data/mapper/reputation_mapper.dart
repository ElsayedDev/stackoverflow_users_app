import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_history_type.dart';
import 'package:stackoverflow_users_app/features/users/data/models/reputation_history_type_model.dart';

extension ReputationHistoryTypeMapper on ReputationHistoryTypeModel {
  ReputationHistoryType toEntity() => switch (this) {
        ReputationHistoryTypeModel.askerAcceptsAnswer =>
          ReputationHistoryType.askerAcceptsAnswer,
        ReputationHistoryTypeModel.askerUnacceptAnswer =>
          ReputationHistoryType.askerUnacceptAnswer,
        ReputationHistoryTypeModel.answerAccepted =>
          ReputationHistoryType.answerAccepted,
        ReputationHistoryTypeModel.answerUnaccepted =>
          ReputationHistoryType.answerUnaccepted,
        ReputationHistoryTypeModel.voterDownvotes =>
          ReputationHistoryType.voterDownvotes,
        ReputationHistoryTypeModel.voterUndownvotes =>
          ReputationHistoryType.voterUndownvotes,
        ReputationHistoryTypeModel.postDownvoted =>
          ReputationHistoryType.postDownvoted,
        ReputationHistoryTypeModel.postUndownvoted =>
          ReputationHistoryType.postUndownvoted,
        ReputationHistoryTypeModel.postUpvoted =>
          ReputationHistoryType.postUpvoted,
        ReputationHistoryTypeModel.postUnupvoted =>
          ReputationHistoryType.postUnupvoted,
        ReputationHistoryTypeModel.suggestedEditApprovalReceived =>
          ReputationHistoryType.suggestedEditApprovalReceived,
        ReputationHistoryTypeModel.postFlaggedAsSpam =>
          ReputationHistoryType.postFlaggedAsSpam,
        ReputationHistoryTypeModel.postFlaggedAsOffensive =>
          ReputationHistoryType.postFlaggedAsOffensive,
        ReputationHistoryTypeModel.bountyGiven =>
          ReputationHistoryType.bountyGiven,
        ReputationHistoryTypeModel.bountyEarned =>
          ReputationHistoryType.bountyEarned,
        ReputationHistoryTypeModel.bountyCancelled =>
          ReputationHistoryType.bountyCancelled,
        ReputationHistoryTypeModel.postDeleted =>
          ReputationHistoryType.postDeleted,
        ReputationHistoryTypeModel.postUndeleted =>
          ReputationHistoryType.postUndeleted,
        ReputationHistoryTypeModel.associationBonus =>
          ReputationHistoryType.associationBonus,
        ReputationHistoryTypeModel.arbitraryReputationChange =>
          ReputationHistoryType.arbitraryReputationChange,
        ReputationHistoryTypeModel.voteFraudReversal =>
          ReputationHistoryType.voteFraudReversal,
        ReputationHistoryTypeModel.postMigrated =>
          ReputationHistoryType.postMigrated,
        ReputationHistoryTypeModel.userDeleted =>
          ReputationHistoryType.userDeleted,
        ReputationHistoryTypeModel.exampleUpvoted =>
          ReputationHistoryType.exampleUpvoted,
        ReputationHistoryTypeModel.exampleUnupvoted =>
          ReputationHistoryType.exampleUnupvoted,
        ReputationHistoryTypeModel.proposedChangeApproved =>
          ReputationHistoryType.proposedChangeApproved,
        ReputationHistoryTypeModel.docLinkUpvoted =>
          ReputationHistoryType.docLinkUpvoted,
        ReputationHistoryTypeModel.docLinkUnupvoted =>
          ReputationHistoryType.docLinkUnupvoted,
        ReputationHistoryTypeModel.docSourceRemoved =>
          ReputationHistoryType.docSourceRemoved,
        ReputationHistoryTypeModel.suggestedEditApprovalOverridden =>
          ReputationHistoryType.suggestedEditApprovalOverridden,
        ReputationHistoryTypeModel.unknown => ReputationHistoryType.unknown
      };
}
