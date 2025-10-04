import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/core/utils/execute.dart';
import 'package:stackoverflow_users_app/core/utils/paginated.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_local_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_remote_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/mapper/reputation_mapper.dart';
import 'package:stackoverflow_users_app/features/users/data/mapper/user_mapper.dart';
import 'package:stackoverflow_users_app/features/users/data/models/cache_user_page.dart';
import 'package:stackoverflow_users_app/features/users/data/models/reputation_history_response.dart';
import 'package:stackoverflow_users_app/features/users/data/models/users_response.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource _remote;
  final UsersLocalDataSource _local;

  UsersRepositoryImpl(this._remote, this._local);

  // ---------------------- Users ----------------------

  @override
  Future<Either<Failure, Paginated<UserEntity>>> getUsers(int page) async {
    if (page < 1) {
      return left(const UnknownFailure('Invalid page index.'));
    }

    return execute(
      () async {
        final UsersResponse response = await _remote.getUsers(page);
        // Cache raw json for offline fallback
        await _local.cacheUsersPage(
          CacheUserPage(
            page: page,
            hasMore: response.hasMore,
            users: response.items,
          ),
        );

        final users = response.items
            .map((model) => model.toEntity())
            .toList(growable: false);

        return Paginated(items: users, hasMore: response.hasMore);
      },
      tag: 'UsersRepository.getUsers',
      onFailure: (error, stack) {
        final cached = _tryGetCachedUsers(page);

        // return left error
        if (cached == null) return null;

        return cached;
      },
    );
  }

  Paginated<UserEntity>? _tryGetCachedUsers(int page) {
    try {
      final cached = _local.getCachedUsersPage(page);
      if (cached == null) return null;

      final users =
          cached.users.map((model) => model.toEntity()).toList(growable: false);

      return Paginated(items: users, hasMore: cached.hasMore);
    } catch (_) {
      return null;
    }
  }

  // ------------------- Reputation --------------------

  @override
  Future<Either<Failure, Paginated<ReputationEntity>>> getReputation(
    int userId,
    int page,
  ) async {
    if (page < 1) {
      return left(const UnknownFailure('Invalid page index.'));
    }

    return execute(
      () async {
        final ReputationHistoryResponse response =
            await _remote.getReputation(userId, page);

        final entities = response.items
            .map((item) => item.toEntity())
            .toList(growable: false);

        return Paginated(items: entities, hasMore: response.hasMore);
      },
      tag: 'UsersRepository.getReputation',
    );
  }

  // ------------------- Bookmarks ---------------------

  @override
  Future<Either<Failure, Unit>> toggleBookmark(int userId) async {
    return execute(
      () async {
        final current = _local.getBookmarkIds();
        final updated = Set<int>.from(current);

        if (!updated.add(userId)) {
          updated.remove(userId);
        }

        await _local.saveBookmarkIds(updated); // triggers watch stream
        return unit;
      },
      tag: 'UsersRepository.toggleBookmark',
    );
  }

  @override
  Stream<Either<Failure, Set<int>>> watchBookmarks() {
    return executeStream(
      () => _bookmarkStream(),
      tag: 'UsersRepository.watchBookmarks',
    );
  }

  Stream<Set<int>> _bookmarkStream() async* {
    final snapshot = _local.getBookmarkIds();
    yield Set<int>.unmodifiable(Set<int>.from(snapshot));

    yield* _local.watchBookmarkIds().map(
          (ids) => Set<int>.unmodifiable(Set<int>.from(ids)),
        );
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByIds(List<int> ids) =>
      execute(
        () async {
          final users = await _local.getUsersByIds(ids);
          return users.map((model) => model.toEntity()).toList();
        },
        tag: 'UsersRepository.getUsersByIds',
      );

  @override
  Future<Either<Failure, UserEntity>> getUserById(int userId) async {
    try {
      final snapshot = _local.getUserSnapshot(userId);
      if (snapshot == null) {
        return left(CacheFailure('User $userId not found in cache.'));
      }

      return right(snapshot.toEntity());
    } catch (error) {
      return left(Failure.fromException(error));
    }
  }
}
