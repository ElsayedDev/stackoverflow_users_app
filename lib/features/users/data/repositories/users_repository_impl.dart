import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_local_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_remote_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/mapper/reputation_mapper.dart';
import 'package:stackoverflow_users_app/features/users/data/mapper/user_mapper.dart';
import 'package:stackoverflow_users_app/features/users/data/models/reputation_history_response.dart';
import 'package:stackoverflow_users_app/features/users/data/models/users_response.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl({
    required UsersRemoteDataSource remote,
    required UsersLocalDataSource local,
  })  : _remote = remote,
        _local = local {
    _initialiseBookmarks();
  }

  final UsersRemoteDataSource _remote;
  final UsersLocalDataSource _local;

  final _bookmarkController =
      StreamController<Either<Failure, Set<int>>>.broadcast();
  Set<int> _bookmarks = <int>{};

  void _initialiseBookmarks() {
    try {
      _bookmarks = _local.getBookmarkIds();
      _emitBookmarks();
    } catch (e) {
      _bookmarkController.add(left(Failure.fromException(e)));
    }
  }

  void _emitBookmarks() {
    _bookmarkController.add(right(Set<int>.unmodifiable(_bookmarks)));
  }

  @override
  Future<Either<Failure, (List<UserEntity>, bool)>> getUsers(int page) async {
    if (page < 1) {
      return left(const UnknownFailure('Invalid page index.'));
    }

    try {
      final UsersResponse response = await _remote.getUsers(page);
      await _local.cacheUsersPage(page, response.toJson());

      final users = response.items
          .map((model) => model.toEntity())
          .toList(growable: false);
      return right((users, response.hasMore));
    } catch (error) {
      final cached = _tryGetCachedUsers(page);
      if (cached != null) {
        return right(cached);
      }
      return left(Failure.fromException(error));
    }
  }

  (List<UserEntity>, bool)? _tryGetCachedUsers(int page) {
    try {
      final cachedJson = _local.getCachedUsersPage(page);
      if (cachedJson == null) return null;
      final cachedResponse = UsersResponse.fromJson(cachedJson);
      final users = cachedResponse.items
          .map((model) => model.toEntity())
          .toList(growable: false);
      return (users, cachedResponse.hasMore);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Either<Failure, (List<ReputationEntity>, bool)>> getReputation(
      int userId, int page) async {
    if (page < 1) {
      return left(const UnknownFailure('Invalid page index.'));
    }

    try {
      final ReputationHistoryResponse response =
          await _remote.getReputation(userId, page);
      final entities =
          response.items.map((item) => item.toEntity()).toList(growable: false);
      return right((entities, response.hasMore));
    } catch (error) {
      return left(Failure.fromException(error));
    }
  }

  @override
  Either<Failure, Set<int>> getBookmarksOnce() {
    try {
      return right(Set<int>.unmodifiable(_bookmarks));
    } catch (error) {
      return left(Failure.fromException(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleBookmark(int userId) async {
    try {
      final updated = Set<int>.from(_bookmarks);
      if (!updated.add(userId)) {
        updated.remove(userId);
      }

      await _local.saveBookmarkIds(updated);
      _bookmarks = updated;
      _emitBookmarks();
      return right(unit);
    } catch (error) {
      return left(Failure.fromException(error));
    }
  }

  @override
  Stream<Either<Failure, Set<int>>> watchBookmarks() =>
      _bookmarkController.stream;
}
