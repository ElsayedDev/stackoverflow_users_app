// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cache_user_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CacheUserPage _$CacheUserPageFromJson(Map<String, dynamic> json) {
  return _CacheUserPage.fromJson(json);
}

/// @nodoc
mixin _$CacheUserPage {
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more')
  bool get hasMore => throw _privateConstructorUsedError;
  List<UserModel> get users => throw _privateConstructorUsedError;

  /// Serializes this CacheUserPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CacheUserPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CacheUserPageCopyWith<CacheUserPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacheUserPageCopyWith<$Res> {
  factory $CacheUserPageCopyWith(
          CacheUserPage value, $Res Function(CacheUserPage) then) =
      _$CacheUserPageCopyWithImpl<$Res, CacheUserPage>;
  @useResult
  $Res call(
      {int page,
      @JsonKey(name: 'has_more') bool hasMore,
      List<UserModel> users});
}

/// @nodoc
class _$CacheUserPageCopyWithImpl<$Res, $Val extends CacheUserPage>
    implements $CacheUserPageCopyWith<$Res> {
  _$CacheUserPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CacheUserPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? hasMore = null,
    Object? users = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CacheUserPageImplCopyWith<$Res>
    implements $CacheUserPageCopyWith<$Res> {
  factory _$$CacheUserPageImplCopyWith(
          _$CacheUserPageImpl value, $Res Function(_$CacheUserPageImpl) then) =
      __$$CacheUserPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      @JsonKey(name: 'has_more') bool hasMore,
      List<UserModel> users});
}

/// @nodoc
class __$$CacheUserPageImplCopyWithImpl<$Res>
    extends _$CacheUserPageCopyWithImpl<$Res, _$CacheUserPageImpl>
    implements _$$CacheUserPageImplCopyWith<$Res> {
  __$$CacheUserPageImplCopyWithImpl(
      _$CacheUserPageImpl _value, $Res Function(_$CacheUserPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of CacheUserPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? hasMore = null,
    Object? users = null,
  }) {
    return _then(_$CacheUserPageImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CacheUserPageImpl implements _CacheUserPage {
  const _$CacheUserPageImpl(
      {required this.page,
      @JsonKey(name: 'has_more') required this.hasMore,
      required final List<UserModel> users})
      : _users = users;

  factory _$CacheUserPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CacheUserPageImplFromJson(json);

  @override
  final int page;
  @override
  @JsonKey(name: 'has_more')
  final bool hasMore;
  final List<UserModel> _users;
  @override
  List<UserModel> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'CacheUserPage(page: $page, hasMore: $hasMore, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheUserPageImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, page, hasMore, const DeepCollectionEquality().hash(_users));

  /// Create a copy of CacheUserPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheUserPageImplCopyWith<_$CacheUserPageImpl> get copyWith =>
      __$$CacheUserPageImplCopyWithImpl<_$CacheUserPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CacheUserPageImplToJson(
      this,
    );
  }
}

abstract class _CacheUserPage implements CacheUserPage {
  const factory _CacheUserPage(
      {required final int page,
      @JsonKey(name: 'has_more') required final bool hasMore,
      required final List<UserModel> users}) = _$CacheUserPageImpl;

  factory _CacheUserPage.fromJson(Map<String, dynamic> json) =
      _$CacheUserPageImpl.fromJson;

  @override
  int get page;
  @override
  @JsonKey(name: 'has_more')
  bool get hasMore;
  @override
  List<UserModel> get users;

  /// Create a copy of CacheUserPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CacheUserPageImplCopyWith<_$CacheUserPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
