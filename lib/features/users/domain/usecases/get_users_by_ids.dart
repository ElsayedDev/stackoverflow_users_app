import 'package:dartz/dartz.dart' show right;
import 'package:stackoverflow_users_app/core/types/aliases.dart';
import 'package:stackoverflow_users_app/core/usecases/use_case.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

class GetUsersByIds
    implements UseCase<FutureEither<List<UserEntity>>, GetUsersByIdsParams> {
  const GetUsersByIds(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<List<UserEntity>> call(GetUsersByIdsParams params) async {
    if (params.ids.isEmpty) {
      return Future.value(right(<UserEntity>[]));
    }

    return _repository.getUsersByIds(params.ids);
  }
}

class GetUsersByIdsParams {
  const GetUsersByIdsParams({required this.ids});

  final List<int> ids;
}
