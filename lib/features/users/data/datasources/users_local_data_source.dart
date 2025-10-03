import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

abstract class UsersLocalDataSource {
  Future<void> cacheUsersPage(int page, Map<String, dynamic> json);
  Map<String, dynamic>? getCachedUsersPage(int page);

  Future<void> saveBookmarkIds(Set<int> ids);
  Set<int> getBookmarkIds();
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
    if (Hive.isBoxOpen(name)) {
      return Hive.box<dynamic>(name);
    }
    return Hive.openBox<dynamic>(name);
  }

  static String _pageKey(int page) => 'page_$page';

  @override
  Future<void> cacheUsersPage(int page, Map<String, dynamic> json) async {
    await _usersBox.put(_pageKey(page), jsonEncode(json));
  }

  @override
  Map<String, dynamic>? getCachedUsersPage(int page) {
    final dynamic raw = _usersBox.get(_pageKey(page));
    if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return decoded.map(
          (key, value) => MapEntry(key.toString(), value),
        );
      }
    }
    return null;
  }

  @override
  Future<void> saveBookmarkIds(Set<int> ids) async {
    await _bookmarksBox.put(_bookmarkKey, ids.toList());
  }

  @override
  Set<int> getBookmarkIds() {
    final dynamic raw = _bookmarksBox.get(_bookmarkKey);
    if (raw is List) {
      return Set<int>.unmodifiable(raw.whereType<int>());
    }
    return const <int>{};
  }
}

class InMemoryUsersLocalDataSource implements UsersLocalDataSource {
  final Map<int, Map<String, dynamic>> _cachedPages =
      <int, Map<String, dynamic>>{};
  Set<int> _bookmarkIds = <int>{};

  @override
  Future<void> cacheUsersPage(int page, Map<String, dynamic> json) async {
    _cachedPages[page] = Map<String, dynamic>.unmodifiable(json);
  }

  @override
  Map<String, dynamic>? getCachedUsersPage(int page) => _cachedPages[page];

  @override
  Future<void> saveBookmarkIds(Set<int> ids) async {
    _bookmarkIds = Set<int>.from(ids);
  }

  @override
  Set<int> getBookmarkIds() => Set<int>.unmodifiable(_bookmarkIds);
}
