// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reputation_history_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReputationHistoryResponse _$ReputationHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return _ReputationHistoryResponse.fromJson(json);
}

/// @nodoc
mixin _$ReputationHistoryResponse {
  List<ReputationItemModel> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more')
  bool get hasMore => throw _privateConstructorUsedError;
  @JsonKey(name: 'quota_max')
  int get quotaMax => throw _privateConstructorUsedError;
  @JsonKey(name: 'quota_remaining')
  int get quotaRemaining => throw _privateConstructorUsedError;

  /// Serializes this ReputationHistoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReputationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReputationHistoryResponseCopyWith<ReputationHistoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReputationHistoryResponseCopyWith<$Res> {
  factory $ReputationHistoryResponseCopyWith(ReputationHistoryResponse value,
          $Res Function(ReputationHistoryResponse) then) =
      _$ReputationHistoryResponseCopyWithImpl<$Res, ReputationHistoryResponse>;
  @useResult
  $Res call(
      {List<ReputationItemModel> items,
      @JsonKey(name: 'has_more') bool hasMore,
      @JsonKey(name: 'quota_max') int quotaMax,
      @JsonKey(name: 'quota_remaining') int quotaRemaining});
}

/// @nodoc
class _$ReputationHistoryResponseCopyWithImpl<$Res,
        $Val extends ReputationHistoryResponse>
    implements $ReputationHistoryResponseCopyWith<$Res> {
  _$ReputationHistoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReputationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? quotaMax = null,
    Object? quotaRemaining = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReputationItemModel>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      quotaMax: null == quotaMax
          ? _value.quotaMax
          : quotaMax // ignore: cast_nullable_to_non_nullable
              as int,
      quotaRemaining: null == quotaRemaining
          ? _value.quotaRemaining
          : quotaRemaining // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReputationHistoryResponseImplCopyWith<$Res>
    implements $ReputationHistoryResponseCopyWith<$Res> {
  factory _$$ReputationHistoryResponseImplCopyWith(
          _$ReputationHistoryResponseImpl value,
          $Res Function(_$ReputationHistoryResponseImpl) then) =
      __$$ReputationHistoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ReputationItemModel> items,
      @JsonKey(name: 'has_more') bool hasMore,
      @JsonKey(name: 'quota_max') int quotaMax,
      @JsonKey(name: 'quota_remaining') int quotaRemaining});
}

/// @nodoc
class __$$ReputationHistoryResponseImplCopyWithImpl<$Res>
    extends _$ReputationHistoryResponseCopyWithImpl<$Res,
        _$ReputationHistoryResponseImpl>
    implements _$$ReputationHistoryResponseImplCopyWith<$Res> {
  __$$ReputationHistoryResponseImplCopyWithImpl(
      _$ReputationHistoryResponseImpl _value,
      $Res Function(_$ReputationHistoryResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReputationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? quotaMax = null,
    Object? quotaRemaining = null,
  }) {
    return _then(_$ReputationHistoryResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReputationItemModel>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      quotaMax: null == quotaMax
          ? _value.quotaMax
          : quotaMax // ignore: cast_nullable_to_non_nullable
              as int,
      quotaRemaining: null == quotaRemaining
          ? _value.quotaRemaining
          : quotaRemaining // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReputationHistoryResponseImpl implements _ReputationHistoryResponse {
  const _$ReputationHistoryResponseImpl(
      {required final List<ReputationItemModel> items,
      @JsonKey(name: 'has_more') required this.hasMore,
      @JsonKey(name: 'quota_max') required this.quotaMax,
      @JsonKey(name: 'quota_remaining') required this.quotaRemaining})
      : _items = items;

  factory _$ReputationHistoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReputationHistoryResponseImplFromJson(json);

  final List<ReputationItemModel> _items;
  @override
  List<ReputationItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'has_more')
  final bool hasMore;
  @override
  @JsonKey(name: 'quota_max')
  final int quotaMax;
  @override
  @JsonKey(name: 'quota_remaining')
  final int quotaRemaining;

  @override
  String toString() {
    return 'ReputationHistoryResponse(items: $items, hasMore: $hasMore, quotaMax: $quotaMax, quotaRemaining: $quotaRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReputationHistoryResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.quotaMax, quotaMax) ||
                other.quotaMax == quotaMax) &&
            (identical(other.quotaRemaining, quotaRemaining) ||
                other.quotaRemaining == quotaRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      hasMore,
      quotaMax,
      quotaRemaining);

  /// Create a copy of ReputationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReputationHistoryResponseImplCopyWith<_$ReputationHistoryResponseImpl>
      get copyWith => __$$ReputationHistoryResponseImplCopyWithImpl<
          _$ReputationHistoryResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReputationHistoryResponseImplToJson(
      this,
    );
  }
}

abstract class _ReputationHistoryResponse implements ReputationHistoryResponse {
  const factory _ReputationHistoryResponse(
      {required final List<ReputationItemModel> items,
      @JsonKey(name: 'has_more') required final bool hasMore,
      @JsonKey(name: 'quota_max') required final int quotaMax,
      @JsonKey(name: 'quota_remaining')
      required final int quotaRemaining}) = _$ReputationHistoryResponseImpl;

  factory _ReputationHistoryResponse.fromJson(Map<String, dynamic> json) =
      _$ReputationHistoryResponseImpl.fromJson;

  @override
  List<ReputationItemModel> get items;
  @override
  @JsonKey(name: 'has_more')
  bool get hasMore;
  @override
  @JsonKey(name: 'quota_max')
  int get quotaMax;
  @override
  @JsonKey(name: 'quota_remaining')
  int get quotaRemaining;

  /// Create a copy of ReputationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReputationHistoryResponseImplCopyWith<_$ReputationHistoryResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
