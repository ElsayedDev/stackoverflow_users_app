import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/core/utils/paginated.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/badge_counts.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_history_type.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

class MockUsersRepository implements UsersRepository {
  MockUsersRepository({this.pageSize = 20}) {
    _emitBookmarks();
  }

  final int pageSize;
  final _bookmarks = <int>{};
  final _bookmarkController =
      StreamController<Either<Failure, Set<int>>>.broadcast();
  final _reputationCache = <int, List<ReputationEntity>>{};

  final List<UserEntity> _users = List.generate(120, (index) {
    final badgeBase = (index % 5) + 1;
    return UserEntity(
      id: index + 1,
      name: 'User ${(index + 1).toString().padLeft(3, '0')}',
      avatar: 'https://i.pravatar.cc/150?img=${(index % 70) + 1}',
      reputation: 25_000 - (index * 73),
      badgeCounts: BadgeCounts(
        gold: max(0, badgeBase - 1),
        silver: max(0, badgeBase * 2 - 3),
        bronze: max(0, badgeBase * 3 - 2),
      ),
      location: index.isEven ? 'Remote' : 'San Francisco, CA',
    );
  });

  void _emitBookmarks() {
    _bookmarkController.add(right(Set<int>.unmodifiable(_bookmarks)));
  }

  @override
  Future<Either<Failure, Paginated<UserEntity>>> getUsers(int page) async {
    await Future.delayed(const Duration(milliseconds: 350));
    if (page < 1) {
      return left(const UnknownFailure('Invalid page index.'));
    }

    final start = (page - 1) * pageSize;
    if (start >= _users.length) {
      return right(const Paginated<UserEntity>(
        items: <UserEntity>[],
        hasMore: false,
      ));
    }

    final end = min(start + pageSize, _users.length);
    final slice = _users.sublist(start, end);
    final hasMore = end < _users.length;
    return right(Paginated(items: slice, hasMore: hasMore));
  }

  @override
  Future<Either<Failure, Paginated<ReputationEntity>>> getReputation(
      int userId, int page) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (page < 1) {
      return left(const UnknownFailure('Invalid page index.'));
    }

    final feed = _reputationCache.putIfAbsent(
      userId,
      () => _buildReputationFeed(userId),
    );

    final start = (page - 1) * pageSize;
    if (start >= feed.length) {
      return right(const Paginated<ReputationEntity>(
        items: <ReputationEntity>[],
        hasMore: false,
      ));
    }

    final end = min(start + pageSize, feed.length);
    final slice = feed.sublist(start, end);
    final hasMore = end < feed.length;
    return right(Paginated(items: slice, hasMore: hasMore));
  }

  List<ReputationEntity> _buildReputationFeed(int userId) {
    final baseDate = DateTime.now();
    const totalItems = 75;

    const positiveTypes = <ReputationHistoryType>[
      ReputationHistoryType.postUpvoted,
      ReputationHistoryType.answerAccepted,
      ReputationHistoryType.bountyEarned,
      ReputationHistoryType.associationBonus,
      ReputationHistoryType.suggestedEditApprovalReceived,
      ReputationHistoryType.exampleUpvoted,
      ReputationHistoryType.docLinkUpvoted,
      ReputationHistoryType.proposedChangeApproved,
    ];

    const negativeTypes = <ReputationHistoryType>[
      ReputationHistoryType.postDownvoted,
      ReputationHistoryType.voterDownvotes,
      ReputationHistoryType.answerUnaccepted,
      ReputationHistoryType.postFlaggedAsOffensive,
      ReputationHistoryType.postFlaggedAsSpam,
      ReputationHistoryType.voteFraudReversal,
      ReputationHistoryType.postDeleted,
      ReputationHistoryType.docLinkUnupvoted,
    ];

    return List<ReputationEntity>.generate(totalItems, (index) {
      final isPositive = index % 3 != 0; // two positives, one negative cadence
      final changeMagnitude = 5 + (index % 7) * 5;
      final type = isPositive
          ? positiveTypes[index % positiveTypes.length]
          : negativeTypes[index % negativeTypes.length];
      final change = isPositive ? changeMagnitude : -changeMagnitude;
      final postId = userId * 1000 + index + 1;
      final createdAt = baseDate.subtract(Duration(days: index * 2 + userId % 5));

      return ReputationEntity(
        type: type,
        change: change,
        postId: postId,
        createdAt: createdAt,
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> toggleBookmark(int userId) async {
    if (_bookmarks.contains(userId)) {
      _bookmarks.remove(userId);
    } else {
      _bookmarks.add(userId);
    }
    _emitBookmarks();
    return right(unit);
  }

  @override
  Stream<Either<Failure, Set<int>>> watchBookmarks() =>
      _bookmarkController.stream;

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByIds(List<int> ids) async {
    if (ids.isEmpty) {
      return right(<UserEntity>[]);
    }

    final lookup = {for (final user in _users) user.id: user};
    final results = <UserEntity>[];
    for (final id in ids) {
      final user = lookup[id];
      if (user != null) {
        results.add(user);
      }
    }

    return right(results);
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int userId) async {
    try {
      final user = _users.firstWhere((user) => user.id == userId);
      return right(user);
    } catch (_) {
      return left(CacheFailure('User $userId not found.'));
    }
  }
}
