import 'package:stackoverflow_users_app/core/types/aliases.dart';
import 'package:stackoverflow_users_app/core/usecases/use_case.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

class WatchBookmarks implements UseCase<StreamEither<Set<int>>, NoParams> {
  const WatchBookmarks(this._repository);

  final UsersRepository _repository;

  @override
  StreamEither<Set<int>> call([NoParams _]) => _repository.watchBookmarks();
}
