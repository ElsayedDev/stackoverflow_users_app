import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/core/utils/paginated.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_reputation.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_user_by_id.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_users.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_users_by_ids.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/toggle_bookmark.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/watch_bookmarks.dart';

import '../../../helpers/fakes.dart';

void main() {
  group('UseCases', () {
    test('GetUsers delegates to repository and returns paginated users',
        () async {
      final repo = StubUsersRepository()
        ..onGetUsers = (page) async {
          expect(page, 2);
          return right(Paginated(items: [makeUserEntity(1)], hasMore: true));
        };

      final usecase = GetUsers(repo);
      final res = await usecase(const GetUsersParams(page: 2));
      expect(res.isRight(), true);
      res.fold(
        (_) => fail('expected Right'),
        (p) {
          expect(p.items.length, 1);
          expect(p.hasMore, true);
        },
      );
    });

    test('GetReputation forwards params and returns paginated reputation',
        () async {
      final repo = StubUsersRepository()
        ..onGetReputation = (userId, page) async {
          expect(userId, 10);
          expect(page, 1);
          return right(Paginated(items: [makeRep(1)], hasMore: false));
        };

      final usecase = GetReputation(repo);
      final res = await usecase(const GetReputationParams(userId: 10, page: 1));
      expect(res.isRight(), true);
    });

    test('ToggleBookmark relays userId and returns unit', () async {
      final repo = StubUsersRepository()
        ..onToggleBookmark = (userId) async {
          expect(userId, 99);
          return right(unit);
        };

      final usecase = ToggleBookmark(repo);
      final res = await usecase(const ToggleBookmarkParams(userId: 99));
      expect(res.isRight(), true);
    });

    test('WatchBookmarks exposes stream from repo', () async {
      final controller = Stream<Either<Failure, Set<int>>>.value(right({1, 2}));
      final repo = StubUsersRepository()..onWatchBookmarks = () => controller;
      final usecase = WatchBookmarks(repo);
      final first = await usecase(null).first;
      first.fold((_) => fail('expected Right'), (ids) => expect(ids, {1, 2}));
    });

    test('GetUsersByIds returns empty immediately when ids empty', () async {
      final repo = StubUsersRepository();
      final usecase = GetUsersByIds(repo);
      final res = await usecase(const GetUsersByIdsParams(ids: []));
      res.fold((_) => fail('expected Right'), (list) => expect(list, isEmpty));
    });

    test('GetUsersByIds calls repo for non-empty ids', () async {
      final repo = StubUsersRepository()
        ..onGetUsersByIds = (ids) async {
          expect(ids, [5, 6]);
          return right([makeUserEntity(5), makeUserEntity(6)]);
        };

      final usecase = GetUsersByIds(repo);
      final res = await usecase(const GetUsersByIdsParams(ids: [5, 6]));
      res.fold((_) => fail('expected Right'), (list) => expect(list.length, 2));
    });

    test('GetUserById forwards to repo', () async {
      final repo = StubUsersRepository()
        ..onGetUserById = (id) async {
          expect(id, 7);
          return right(makeUserEntity(7));
        };

      final usecase = GetUserById(repo);
      final res = await usecase(const GetUserByIdParams(userId: 7));
      res.fold((_) => fail('expected Right'), (u) => expect(u.id, 7));
    });
  });
}
