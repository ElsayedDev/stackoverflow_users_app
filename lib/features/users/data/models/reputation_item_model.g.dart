// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reputation_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReputationItemModelImpl _$$ReputationItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReputationItemModelImpl(
      reputationHistoryType: $enumDecode(
          _$ReputationHistoryTypeModelEnumMap, json['reputation_history_type']),
      reputationChange: (json['reputation_change'] as num).toInt(),
      postId: (json['post_id'] as num).toInt(),
      creationDate: (json['creation_date'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$$ReputationItemModelImplToJson(
        _$ReputationItemModelImpl instance) =>
    <String, dynamic>{
      'reputation_history_type':
          _$ReputationHistoryTypeModelEnumMap[instance.reputationHistoryType]!,
      'reputation_change': instance.reputationChange,
      'post_id': instance.postId,
      'creation_date': instance.creationDate,
      'user_id': instance.userId,
    };

const _$ReputationHistoryTypeModelEnumMap = {
  ReputationHistoryTypeModel.askerAcceptsAnswer: 'asker_accepts_answer',
  ReputationHistoryTypeModel.askerUnacceptAnswer: 'asker_unaccept_answer',
  ReputationHistoryTypeModel.answerAccepted: 'answer_accepted',
  ReputationHistoryTypeModel.answerUnaccepted: 'answer_unaccepted',
  ReputationHistoryTypeModel.voterDownvotes: 'voter_downvotes',
  ReputationHistoryTypeModel.voterUndownvotes: 'voter_undownvotes',
  ReputationHistoryTypeModel.postDownvoted: 'post_downvoted',
  ReputationHistoryTypeModel.postUndownvoted: 'post_undownvoted',
  ReputationHistoryTypeModel.postUpvoted: 'post_upvoted',
  ReputationHistoryTypeModel.postUnupvoted: 'post_unupvoted',
  ReputationHistoryTypeModel.suggestedEditApprovalReceived:
      'suggested_edit_approval_received',
  ReputationHistoryTypeModel.postFlaggedAsSpam: 'post_flagged_as_spam',
  ReputationHistoryTypeModel.postFlaggedAsOffensive:
      'post_flagged_as_offensive',
  ReputationHistoryTypeModel.bountyGiven: 'bounty_given',
  ReputationHistoryTypeModel.bountyEarned: 'bounty_earned',
  ReputationHistoryTypeModel.bountyCancelled: 'bounty_cancelled',
  ReputationHistoryTypeModel.postDeleted: 'post_deleted',
  ReputationHistoryTypeModel.postUndeleted: 'post_undeleted',
  ReputationHistoryTypeModel.associationBonus: 'association_bonus',
  ReputationHistoryTypeModel.arbitraryReputationChange:
      'arbitrary_reputation_change',
  ReputationHistoryTypeModel.voteFraudReversal: 'vote_fraud_reversal',
  ReputationHistoryTypeModel.postMigrated: 'post_migrated',
  ReputationHistoryTypeModel.userDeleted: 'user_deleted',
  ReputationHistoryTypeModel.exampleUpvoted: 'example_upvoted',
  ReputationHistoryTypeModel.exampleUnupvoted: 'example_unupvoted',
  ReputationHistoryTypeModel.proposedChangeApproved: 'proposed_change_approved',
  ReputationHistoryTypeModel.docLinkUpvoted: 'doc_link_upvoted',
  ReputationHistoryTypeModel.docLinkUnupvoted: 'doc_link_unupvoted',
  ReputationHistoryTypeModel.docSourceRemoved: 'doc_source_removed',
  ReputationHistoryTypeModel.suggestedEditApprovalOverridden:
      'suggested_edit_approval_overridden',
  ReputationHistoryTypeModel.unknown: 'unknown',
};
