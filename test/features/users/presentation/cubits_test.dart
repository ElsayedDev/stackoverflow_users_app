import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/bookmarks/bookmarks_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_users.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_users_by_ids.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/toggle_bookmark.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/watch_bookmarks.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_reputation.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_user_by_id.dart';
import 'package:stackoverflow_users_app/core/utils/paginated.dart';

import '../../../helpers/fakes.dart';

void main() {
  group('UsersCubit', () {
    test('loads first page and then loads more', () async {
      final repo = StubUsersRepository();
      repo.onGetUsers = (page) async => right(Paginated(
            items: [makeUserEntity(page)],
            hasMore: page < 2,
          ));
      repo.onWatchBookmarks = () => Stream.value(right(<int>{}));
      final cubit = UsersCubit(
          GetUsers(repo), WatchBookmarks(repo), ToggleBookmark(repo));

      await cubit.onLoadInit();
      expect(cubit.state.users.length, 1);
      expect(cubit.state.hasMore, true);

      await cubit.onLoadMore();
      expect(cubit.state.users.length, 2);
      expect(cubit.state.hasMore, false);
    });
  });

  group('BookmarksCubit', () {
    test('reacts to bookmark stream and loads users by ids', () async {
      final repo = StubUsersRepository();
      repo.onWatchBookmarks = () => Stream.value(right(<int>{1, 2, 3}));
      repo.onToggleBookmark = (id) async => right(unit);
      repo.onGetUsersByIds =
          (ids) async => right(ids.map(makeUserEntity).toList());

      final cubit = BookmarksCubit(
        getUsersByIds: GetUsersByIds(repo),
        toggleBookmark: ToggleBookmark(repo),
        watchBookmarks: WatchBookmarks(repo),
        pageSize: 2,
      );

      // Give the subscription a turn to process the emitted bookmarks
      await Future<void>.delayed(Duration.zero);

      // Now load with bookmarks present
      await cubit.onLoadInit(force: true);
      expect(cubit.state.users.length, 2);
      expect(cubit.state.hasMore, true);

      await cubit.onLoadMore();
      expect(cubit.state.users.length, 3);
      expect(cubit.state.hasMore, false);
    });
  });

  group('ReputationCubit', () {
    test('loads user snapshot then first reputation page and more', () async {
      final repo = StubUsersRepository();
      repo.onGetUserById = (id) async => right(makeUserEntity(id));
      repo.onGetReputation = (id, page) async => right(Paginated(
            items: [makeRep(page)],
            hasMore: page < 2,
          ));

      final cubit = ReputationCubit(GetReputation(repo), GetUserById(repo));

      await cubit.onInit(10);
      expect(cubit.state.user?.id, 10);

      await cubit.onLoadInit();
      expect(cubit.state.items.length, 1);
      expect(cubit.state.hasMore, true);

      await cubit.onLoadMore();
      expect(cubit.state.items.length, 2);
      expect(cubit.state.hasMore, false);
    });
  });
}
