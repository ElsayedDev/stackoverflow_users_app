import 'package:stackoverflow_users_app/core/types/aliases.dart';
import 'package:stackoverflow_users_app/core/usecases/use_case.dart';
import 'package:stackoverflow_users_app/core/utils/paginated.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

class GetReputation
    implements
        UseCase<FutureEither<Paginated<ReputationEntity>>,
            GetReputationParams> {
  const GetReputation(this._repository);

  final UsersRepository _repository;

  @override
  FutureEither<Paginated<ReputationEntity>> call(GetReputationParams params) =>
      _repository.getReputation(params.userId, params.page);
}

class GetReputationParams {
  const GetReputationParams({required this.userId, required this.page});

  final int userId;
  final int page;
}
