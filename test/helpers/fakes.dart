import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/core/utils/paginated.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_local_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_remote_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/models/cache_user_page.dart';
import 'package:stackoverflow_users_app/features/users/data/models/reputation_history_response.dart';
import 'package:stackoverflow_users_app/features/users/data/models/user_model.dart';
import 'package:stackoverflow_users_app/features/users/data/models/users_response.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/badge_counts.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_history_type.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/data/models/reputation_item_model.dart';
import 'package:stackoverflow_users_app/features/users/data/models/reputation_history_type_model.dart';
import 'package:stackoverflow_users_app/features/users/data/models/badge_counts_model.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

/// A configurable stub for [UsersRepository] used by use case and cubit tests.
class StubUsersRepository implements UsersRepository {
  StubUsersRepository();

  Future<Either<Failure, Paginated<UserEntity>>> Function(int page)? onGetUsers;
  Future<Either<Failure, List<UserEntity>>> Function(List<int> ids)?
      onGetUsersByIds;
  Future<Either<Failure, Paginated<ReputationEntity>>> Function(
      int userId, int page)? onGetReputation;
  Future<Either<Failure, Unit>> Function(int userId)? onToggleBookmark;
  Stream<Either<Failure, Set<int>>> Function()? onWatchBookmarks;
  Future<Either<Failure, UserEntity>> Function(int userId)? onGetUserById;

  @override
  Future<Either<Failure, Paginated<UserEntity>>> getUsers(int page) async {
    final fn = onGetUsers;
    if (fn == null) {
      throw UnimplementedError('onGetUsers not provided');
    }
    return fn(page);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByIds(List<int> ids) {
    final fn = onGetUsersByIds;
    if (fn == null) {
      throw UnimplementedError('onGetUsersByIds not provided');
    }
    return fn(ids);
  }

  @override
  Future<Either<Failure, Paginated<ReputationEntity>>> getReputation(
      int userId, int page) async {
    final fn = onGetReputation;
    if (fn == null) {
      throw UnimplementedError('onGetReputation not provided');
    }
    return fn(userId, page);
  }

  @override
  Future<Either<Failure, Unit>> toggleBookmark(int userId) async {
    final fn = onToggleBookmark;
    if (fn == null) {
      throw UnimplementedError('onToggleBookmark not provided');
    }
    return fn(userId);
  }

  @override
  Stream<Either<Failure, Set<int>>> watchBookmarks() {
    final fn = onWatchBookmarks;
    if (fn == null) {
      throw UnimplementedError('onWatchBookmarks not provided');
    }
    return fn();
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int userId) async {
    final fn = onGetUserById;
    if (fn == null) {
      throw UnimplementedError('onGetUserById not provided');
    }
    return fn(userId);
  }
}

/// In-memory fake for [UsersRemoteDataSource].
class FakeUsersRemoteDataSource implements UsersRemoteDataSource {
  FakeUsersRemoteDataSource();

  UsersResponse Function(int page)? onGetUsers;
  ReputationHistoryResponse Function(int userId, int page)? onGetReputation;

  @override
  Future<UsersResponse> getUsers(int page) async {
    final fn = onGetUsers;
    if (fn == null) {
      throw UnimplementedError('onGetUsers not provided');
    }
    return fn(page);
  }

  @override
  Future<ReputationHistoryResponse> getReputation(int userId, int page) async {
    final fn = onGetReputation;
    if (fn == null) {
      throw UnimplementedError('onGetReputation not provided');
    }
    return fn(userId, page);
  }
}

/// In-memory fake for [UsersLocalDataSource].
class FakeUsersLocalDataSource implements UsersLocalDataSource {
  final _pages = <int, CacheUserPage>{};
  final _snapshots = <int, UserModel>{};
  final _bookmarkIds = <int>{};
  final _bookmarkController = StreamController<Set<int>>.broadcast();
  final _reputationPages = <String, ReputationHistoryResponse>{};

  @override
  Future<void> cacheUsersPage(CacheUserPage page) async {
    _pages[page.page] = page;
  }

  @override
  CacheUserPage? getCachedUsersPage(int page) => _pages[page];

  @override
  Future<List<UserModel>> getUsersByIds(List<int> ids) async {
    return ids.map((id) => _snapshots[id]).whereType<UserModel>().toList();
  }

  @override
  Future<void> upsertUserSnapshot(UserModel model) async {
    _snapshots[model.userId] = model;
  }

  @override
  UserModel? getUserSnapshot(int userId) => _snapshots[userId];

  @override
  Future<void> saveBookmarkIds(Set<int> ids) async {
    _bookmarkIds
      ..clear()
      ..addAll(ids);
    _bookmarkController.add(Set<int>.from(_bookmarkIds));
  }

  @override
  Set<int> getBookmarkIds() => Set<int>.from(_bookmarkIds);

  @override
  Stream<Set<int>> watchBookmarkIds() => _bookmarkController.stream;

  @override
  Future<void> clearUsersPages() async {
    _pages.clear();
  }

  @override
  Future<void> clearUserSnapshots() async {
    _snapshots.clear();
  }

  // --- Reputation cache (per user, paginated) ---
  String _repKey(int userId, int page) => 'rep_${userId}_$page';

  @override
  Future<void> cacheReputationPage(
      int userId, int page, ReputationHistoryResponse response) async {
    _reputationPages[_repKey(userId, page)] = response;
  }

  @override
  ReputationHistoryResponse? getCachedReputationPage(int userId, int page) {
    return _reputationPages[_repKey(userId, page)];
  }
}

// ---- Test builders ----

UserEntity makeUserEntity(int id) => UserEntity(
      id: id,
      name: 'User $id',
      avatar: 'https://example.com/$id.png',
      reputation: 1000 + id,
      badgeCounts: const BadgeCounts(gold: 1, silver: 2, bronze: 3),
      location: 'Earth',
    );

UserModel makeUserModel(int id) => UserModel(
      accountId: id,
      userId: id,
      displayName: 'User $id',
      profileImage: 'https://example.com/$id.png',
      reputation: 1000 + id,
      badgeCounts: const BadgeCountsModel(gold: 1, silver: 2, bronze: 3),
      location: 'Earth',
    );

ReputationEntity makeRep(int i) => ReputationEntity(
      type: ReputationHistoryType.postUpvoted,
      change: i,
      postId: 1000 + i,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1700000000000 + i),
    );

UsersResponse makeUsersResponse(List<int> ids, {bool hasMore = true}) =>
    UsersResponse(items: ids.map(makeUserModel).toList(), hasMore: hasMore);

ReputationHistoryResponse makeReputationResponse(List<int> changes,
        {bool hasMore = true}) =>
    ReputationHistoryResponse(
      items: changes
          .map((c) => ReputationItemModel(
                postId: 1000 + c,
                reputationChange: c,
                creationDate: 1700000000 + c, // seconds
                userId: 1,
                reputationHistoryType: ReputationHistoryTypeModel.postUpvoted,
              ))
          .toList(),
      hasMore: hasMore,
      quotaMax: 10000,
      quotaRemaining: 9999,
    );
