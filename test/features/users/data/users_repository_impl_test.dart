import 'package:flutter_test/flutter_test.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/features/users/data/models/cache_user_page.dart';
import 'package:stackoverflow_users_app/features/users/data/models/users_response.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/users_repository_impl.dart';

import '../../../helpers/fakes.dart';

void main() {
  group('UsersRepositoryImpl', () {
    test('getUsers returns remote and caches page', () async {
      final remote = FakeUsersRemoteDataSource()
        ..onGetUsers = (page) => makeUsersResponse([1, 2], hasMore: true);
      final local = FakeUsersLocalDataSource();
      final repo = UsersRepositoryImpl(remote, local);

      final res = await repo.getUsers(1);
      expect(res.isRight(), true);
      final cached = local.getCachedUsersPage(1);
      expect(cached, isA<CacheUserPage>());
    });

    test('getUsers falls back to cache on remote failure', () async {
      final remote = _ThrowingRemote();
      final local = FakeUsersLocalDataSource();
      await local.cacheUsersPage(CacheUserPage(
        page: 2,
        hasMore: false,
        users: makeUsersResponse([10]).items,
      ));
      final repo = UsersRepositoryImpl(remote, local);

      final res = await repo.getUsers(2);
      // should be Right via onFailure fallback
      expect(res.isRight(), true);
    });

    test('toggleBookmark persists ids and emits via watch', () async {
      final repo = UsersRepositoryImpl(
          FakeUsersRemoteDataSource(), FakeUsersLocalDataSource());
      final first = await repo.watchBookmarks().first;
      first.fold((_) => fail('expected Right'),
          (ids) => expect(ids.contains(5), false));

      await repo.toggleBookmark(5);

      final second = await repo.watchBookmarks().first;
      second.fold((_) => fail('expected Right'),
          (ids) => expect(ids.contains(5), true));
    });

    test('getUserById returns CacheFailure when snapshot missing', () async {
      final repo = UsersRepositoryImpl(
          FakeUsersRemoteDataSource(), FakeUsersLocalDataSource());
      final res = await repo.getUserById(42);
      res.fold(
        (f) => expect(f, isA<CacheFailure>()),
        (_) => fail('expected Left(CacheFailure)'),
      );
    });

    test('getUserById returns snapshot when present', () async {
      final local = FakeUsersLocalDataSource();
      await local.upsertUserSnapshot(makeUserModel(1));
      final repo = UsersRepositoryImpl(FakeUsersRemoteDataSource(), local);
      final res = await repo.getUserById(1);
      res.fold((_) => fail('expected Right'), (u) => expect(u.id, 1));
    });
  });
}

class _ThrowingRemote extends FakeUsersRemoteDataSource {
  @override
  Future<UsersResponse> getUsers(int page) async {
    throw Exception('network down');
  }
}
