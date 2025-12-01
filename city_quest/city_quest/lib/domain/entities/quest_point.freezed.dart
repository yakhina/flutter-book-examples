// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuestPoint {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get radius => throw _privateConstructorUsedError;
  String get cityId => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Create a copy of QuestPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestPointCopyWith<QuestPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestPointCopyWith<$Res> {
  factory $QuestPointCopyWith(
          QuestPoint value, $Res Function(QuestPoint) then) =
      _$QuestPointCopyWithImpl<$Res, QuestPoint>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      double latitude,
      double longitude,
      double radius,
      String cityId,
      bool isCompleted});
}

/// @nodoc
class _$QuestPointCopyWithImpl<$Res, $Val extends QuestPoint>
    implements $QuestPointCopyWith<$Res> {
  _$QuestPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? radius = null,
    Object? cityId = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double,
      cityId: null == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestPointImplCopyWith<$Res>
    implements $QuestPointCopyWith<$Res> {
  factory _$$QuestPointImplCopyWith(
          _$QuestPointImpl value, $Res Function(_$QuestPointImpl) then) =
      __$$QuestPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      double latitude,
      double longitude,
      double radius,
      String cityId,
      bool isCompleted});
}

/// @nodoc
class __$$QuestPointImplCopyWithImpl<$Res>
    extends _$QuestPointCopyWithImpl<$Res, _$QuestPointImpl>
    implements _$$QuestPointImplCopyWith<$Res> {
  __$$QuestPointImplCopyWithImpl(
      _$QuestPointImpl _value, $Res Function(_$QuestPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? radius = null,
    Object? cityId = null,
    Object? isCompleted = null,
  }) {
    return _then(_$QuestPointImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      radius: null == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double,
      cityId: null == cityId
          ? _value.cityId
          : cityId // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$QuestPointImpl with DiagnosticableTreeMixin implements _QuestPoint {
  const _$QuestPointImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.radius,
      required this.cityId,
      this.isCompleted = false});

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double radius;
  @override
  final String cityId;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QuestPoint(id: $id, title: $title, description: $description, latitude: $latitude, longitude: $longitude, radius: $radius, cityId: $cityId, isCompleted: $isCompleted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QuestPoint'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('radius', radius))
      ..add(DiagnosticsProperty('cityId', cityId))
      ..add(DiagnosticsProperty('isCompleted', isCompleted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestPointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, latitude,
      longitude, radius, cityId, isCompleted);

  /// Create a copy of QuestPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestPointImplCopyWith<_$QuestPointImpl> get copyWith =>
      __$$QuestPointImplCopyWithImpl<_$QuestPointImpl>(this, _$identity);
}

abstract class _QuestPoint implements QuestPoint {
  const factory _QuestPoint(
      {required final String id,
      required final String title,
      required final String description,
      required final double latitude,
      required final double longitude,
      required final double radius,
      required final String cityId,
      final bool isCompleted}) = _$QuestPointImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get radius;
  @override
  String get cityId;
  @override
  bool get isCompleted;

  /// Create a copy of QuestPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestPointImplCopyWith<_$QuestPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
