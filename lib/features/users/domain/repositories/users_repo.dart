import 'package:dartz/dartz.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, (List<UserEntity>, bool hasMore)>> getUsers(int page);
  Future<Either<Failure, (List<ReputationEntity>, bool hasMore)>> getReputation(
      int userId, int page);
  Future<Either<Failure, Unit>> toggleBookmark(int userId);
  Stream<Either<Failure, Set<int>>> watchBookmarks();
  Either<Failure, Set<int>> getBookmarksOnce();
}
