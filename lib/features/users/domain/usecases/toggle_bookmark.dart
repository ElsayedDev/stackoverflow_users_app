import 'package:dartz/dartz.dart';
import 'package:stackoverflow_users_app/core/types/aliases.dart';
import 'package:stackoverflow_users_app/core/usecases/use_case.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';

final class ToggleBookmark
    implements UseCase<FutureEither<Unit>, ToggleBookmarkParams> {
  final UsersRepository _repository;

  const ToggleBookmark(this._repository);

  @override
  FutureEither<Unit> call(ToggleBookmarkParams params) =>
      _repository.toggleBookmark(params.userId);
}

final class ToggleBookmarkParams {
  const ToggleBookmarkParams({required this.userId});

  final int userId;
}
