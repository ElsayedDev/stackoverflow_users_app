import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stackoverflow_users_app/core/utils/map_extensions.dart';
import 'package:stackoverflow_users_app/features/users/data/models/cache_user_page.dart';
import 'package:stackoverflow_users_app/features/users/data/models/user_model.dart';

abstract class UsersLocalDataSource {
  // users cache
  Future<void> cacheUsersPage(CacheUserPage page);
  CacheUserPage? getCachedUsersPage(int page);
  Future<List<UserModel>> getUsersByIds(List<int> ids);

  // single snapshot
  Future<void> upsertUserSnapshot(UserModel model);
  UserModel? getUserSnapshot(int userId);

  // bookmarks
  Future<void> saveBookmarkIds(Set<int> ids);
  Set<int> getBookmarkIds();
  Stream<Set<int>> watchBookmarkIds();

  // maintenance
  Future<void> clearUsersPages();
  Future<void> clearUserSnapshots();
}

class HiveUsersLocalDataSource implements UsersLocalDataSource {
  HiveUsersLocalDataSource({
    required Box<dynamic> usersBox,
    required Box<dynamic> bookmarksBox,
  })  : _usersBox = usersBox,
        _bookmarksBox = bookmarksBox;

  static const String usersCacheBoxName = 'users_cache';
  static const String bookmarksBoxName = 'bookmarks';
  static const String _bookmarkKey = 'bookmark_ids';
  static String _userKey(int id) => 'user_$id';
  static String _pageKey(int page) => 'page_$page';

  final Box<dynamic> _usersBox;
  final Box<dynamic> _bookmarksBox;

  static Future<HiveUsersLocalDataSource> create() async {
    final usersBox = await _openBox(usersCacheBoxName);
    final bookmarksBox = await _openBox(bookmarksBoxName);
    return HiveUsersLocalDataSource(
      usersBox: usersBox,
      bookmarksBox: bookmarksBox,
    );
  }

  static Future<Box<dynamic>> _openBox(String name) async {
    if (Hive.isBoxOpen(name)) return Hive.box<dynamic>(name);
    return Hive.openBox<dynamic>(name);
  }

  @override
  Future<void> cacheUsersPage(CacheUserPage page) async {
    await _usersBox.put(_pageKey(page.page), jsonEncode(page.toJson()));

    // batch write user snapshots
    final batch = {
      for (final u in page.users) _userKey(u.userId): jsonEncode(u.toJson()),
    };
    await _usersBox.putAll(batch);
  }

  @override
  CacheUserPage? getCachedUsersPage(int page) {
    final raw = _usersBox.get(_pageKey(page));
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          return CacheUserPage.fromJson(decoded);
        }
        if (decoded is Map) {
          return CacheUserPage.fromJson(decoded.toStringKeyedMap());
        }
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> upsertUserSnapshot(UserModel model) async {
    await _usersBox.put(_userKey(model.userId), jsonEncode(model.toJson()));
  }

  @override
  UserModel? getUserSnapshot(int userId) {
    final raw = _usersBox.get(_userKey(userId));
    if (raw is! String) return null;

    try {
      final decoded = jsonDecode(raw);
      final map = decoded is Map<String, dynamic>
          ? decoded
          : decoded is Map
              ? decoded.toStringKeyedMap()
              : null;
      return map == null ? null : UserModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<UserModel>> getUsersByIds(List<int> ids) async {
    if (ids.isEmpty) return const <UserModel>[];

    final results = <UserModel>[];
    for (final id in ids) {
      final raw = _usersBox.get(_userKey(id));
      if (raw is! String) continue;

      try {
        final decoded = jsonDecode(raw);
        final map = decoded is Map<String, dynamic>
            ? decoded
            : decoded is Map
                ? decoded.toStringKeyedMap()
                : null;

        if (map != null) results.add(UserModel.fromJson(map));
      } catch (_) {
        continue;
      }
    }
    return results;
  }

  @override
  Future<void> saveBookmarkIds(Set<int> ids) async {
    await _bookmarksBox.put(_bookmarkKey, ids.toList());
  }

  @override
  Set<int> getBookmarkIds() {
    final raw = _bookmarksBox.get(_bookmarkKey);
    if (raw is List) return Set<int>.unmodifiable(raw.whereType<int>());
    return const <int>{};
  }

  @override
  Stream<Set<int>> watchBookmarkIds() {
    final initial = Stream<Set<int>>.value(getBookmarkIds());
    final updates = _bookmarksBox
        .watch(key: _bookmarkKey)
        .map((_) => getBookmarkIds())
        .distinct((a, b) => a.length == b.length && a.containsAll(b));
    return initial.concatWith([updates]);
  }

  @override
  Future<void> clearUsersPages() async {
    final keys = _usersBox.keys
        .where((k) => k is String && k.startsWith('page_'))
        .toList();
    await _usersBox.deleteAll(keys);
  }

  @override
  Future<void> clearUserSnapshots() async {
    final keys = _usersBox.keys
        .where((k) => k is String && k.startsWith('user_'))
        .toList();
    await _usersBox.deleteAll(keys);
  }
}
