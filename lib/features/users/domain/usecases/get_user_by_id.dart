import 'package:stackoverflow_users_app/core/types/aliases.dart';
import 'package:stackoverflow_users_app/core/usecases/use_case.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

class GetUserById
    implements UseCase<FutureEither<UserEntity>, GetUserByIdParams> {
  const GetUserById(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<UserEntity> call(GetUserByIdParams params) =>
      _repository.getUserById(params.userId);
}

class GetUserByIdParams {
  const GetUserByIdParams({required this.userId});

  final int userId;
}
