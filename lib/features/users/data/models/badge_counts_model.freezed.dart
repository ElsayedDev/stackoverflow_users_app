// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_counts_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BadgeCountsModel _$BadgeCountsModelFromJson(Map<String, dynamic> json) {
  return _BadgeCountsModel.fromJson(json);
}

/// @nodoc
mixin _$BadgeCountsModel {
  int get bronze => throw _privateConstructorUsedError;
  int get silver => throw _privateConstructorUsedError;
  int get gold => throw _privateConstructorUsedError;

  /// Serializes this BadgeCountsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BadgeCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BadgeCountsModelCopyWith<BadgeCountsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeCountsModelCopyWith<$Res> {
  factory $BadgeCountsModelCopyWith(
          BadgeCountsModel value, $Res Function(BadgeCountsModel) then) =
      _$BadgeCountsModelCopyWithImpl<$Res, BadgeCountsModel>;
  @useResult
  $Res call({int bronze, int silver, int gold});
}

/// @nodoc
class _$BadgeCountsModelCopyWithImpl<$Res, $Val extends BadgeCountsModel>
    implements $BadgeCountsModelCopyWith<$Res> {
  _$BadgeCountsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BadgeCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bronze = null,
    Object? silver = null,
    Object? gold = null,
  }) {
    return _then(_value.copyWith(
      bronze: null == bronze
          ? _value.bronze
          : bronze // ignore: cast_nullable_to_non_nullable
              as int,
      silver: null == silver
          ? _value.silver
          : silver // ignore: cast_nullable_to_non_nullable
              as int,
      gold: null == gold
          ? _value.gold
          : gold // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BadgeCountsModelImplCopyWith<$Res>
    implements $BadgeCountsModelCopyWith<$Res> {
  factory _$$BadgeCountsModelImplCopyWith(_$BadgeCountsModelImpl value,
          $Res Function(_$BadgeCountsModelImpl) then) =
      __$$BadgeCountsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bronze, int silver, int gold});
}

/// @nodoc
class __$$BadgeCountsModelImplCopyWithImpl<$Res>
    extends _$BadgeCountsModelCopyWithImpl<$Res, _$BadgeCountsModelImpl>
    implements _$$BadgeCountsModelImplCopyWith<$Res> {
  __$$BadgeCountsModelImplCopyWithImpl(_$BadgeCountsModelImpl _value,
      $Res Function(_$BadgeCountsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BadgeCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bronze = null,
    Object? silver = null,
    Object? gold = null,
  }) {
    return _then(_$BadgeCountsModelImpl(
      bronze: null == bronze
          ? _value.bronze
          : bronze // ignore: cast_nullable_to_non_nullable
              as int,
      silver: null == silver
          ? _value.silver
          : silver // ignore: cast_nullable_to_non_nullable
              as int,
      gold: null == gold
          ? _value.gold
          : gold // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BadgeCountsModelImpl implements _BadgeCountsModel {
  const _$BadgeCountsModelImpl(
      {required this.bronze, required this.silver, required this.gold});

  factory _$BadgeCountsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgeCountsModelImplFromJson(json);

  @override
  final int bronze;
  @override
  final int silver;
  @override
  final int gold;

  @override
  String toString() {
    return 'BadgeCountsModel(bronze: $bronze, silver: $silver, gold: $gold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeCountsModelImpl &&
            (identical(other.bronze, bronze) || other.bronze == bronze) &&
            (identical(other.silver, silver) || other.silver == silver) &&
            (identical(other.gold, gold) || other.gold == gold));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bronze, silver, gold);

  /// Create a copy of BadgeCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeCountsModelImplCopyWith<_$BadgeCountsModelImpl> get copyWith =>
      __$$BadgeCountsModelImplCopyWithImpl<_$BadgeCountsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BadgeCountsModelImplToJson(
      this,
    );
  }
}

abstract class _BadgeCountsModel implements BadgeCountsModel {
  const factory _BadgeCountsModel(
      {required final int bronze,
      required final int silver,
      required final int gold}) = _$BadgeCountsModelImpl;

  factory _BadgeCountsModel.fromJson(Map<String, dynamic> json) =
      _$BadgeCountsModelImpl.fromJson;

  @override
  int get bronze;
  @override
  int get silver;
  @override
  int get gold;

  /// Create a copy of BadgeCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadgeCountsModelImplCopyWith<_$BadgeCountsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
