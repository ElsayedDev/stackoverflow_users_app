import 'package:stackoverflow_users_app/core/types/aliases.dart';
import 'package:stackoverflow_users_app/core/usecases/use_case.dart';
import 'package:stackoverflow_users_app/core/utils/paginated.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

class GetUsers
    implements UseCase<FutureEither<Paginated<UserEntity>>, GetUsersParams> {
  const GetUsers(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<Paginated<UserEntity>> call(GetUsersParams params) =>
      _repository.getUsers(params.page);
}

class GetUsersParams {
  const GetUsersParams({required this.page});

  final int page;
}
