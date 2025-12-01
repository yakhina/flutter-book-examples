// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_quest_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CityQuestStats {
  String get cityId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get completed => throw _privateConstructorUsedError;

  /// Create a copy of CityQuestStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CityQuestStatsCopyWith<CityQuestStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityQuestStatsCopyWith<$Res> {
  factory $CityQuestStatsCopyWith(
          CityQuestStats value, $Res Function(CityQuestStats) then) =
      _$CityQuestStatsCopyWithImpl<$Res, CityQuestStats>;
  @useResult
  $Res call({String cityId, String name, int total, int completed});
}

/// @nodoc
class _$CityQuestStatsCopyWithImpl<$Res, $Val extends CityQuestStats>
    implements $CityQuestStatsCopyWith<$Res> {
  _$CityQuestStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CityQuestStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityId = null,
    Object? name = null,
    Object? total = null,
    Object? completed = null,
  }) {
    return _then(_value.copyWith(
      cityId: null == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CityQuestStatsImplCopyWith<$Res>
    implements $CityQuestStatsCopyWith<$Res> {
  factory _$$CityQuestStatsImplCopyWith(_$CityQuestStatsImpl value,
          $Res Function(_$CityQuestStatsImpl) then) =
      __$$CityQuestStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cityId, String name, int total, int completed});
}

/// @nodoc
class __$$CityQuestStatsImplCopyWithImpl<$Res>
    extends _$CityQuestStatsCopyWithImpl<$Res, _$CityQuestStatsImpl>
    implements _$$CityQuestStatsImplCopyWith<$Res> {
  __$$CityQuestStatsImplCopyWithImpl(
      _$CityQuestStatsImpl _value, $Res Function(_$CityQuestStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CityQuestStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityId = null,
    Object? name = null,
    Object? total = null,
    Object? completed = null,
  }) {
    return _then(_$CityQuestStatsImpl(
      cityId: null == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CityQuestStatsImpl implements _CityQuestStats {
  const _$CityQuestStatsImpl(
      {required this.cityId,
      required this.name,
      required this.total,
      required this.completed});

  @override
  final String cityId;
  @override
  final String name;
  @override
  final int total;
  @override
  final int completed;

  @override
  String toString() {
    return 'CityQuestStats(cityId: $cityId, name: $name, total: $total, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityQuestStatsImpl &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityId, name, total, completed);

  /// Create a copy of CityQuestStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityQuestStatsImplCopyWith<_$CityQuestStatsImpl> get copyWith =>
      __$$CityQuestStatsImplCopyWithImpl<_$CityQuestStatsImpl>(
          this, _$identity);
}

abstract class _CityQuestStats implements CityQuestStats {
  const factory _CityQuestStats(
      {required final String cityId,
      required final String name,
      required final int total,
      required final int completed}) = _$CityQuestStatsImpl;

  @override
  String get cityId;
  @override
  String get name;
  @override
  int get total;
  @override
  int get completed;

  /// Create a copy of CityQuestStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityQuestStatsImplCopyWith<_$CityQuestStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
