// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionEntity _$SessionEntityFromJson(Map<String, dynamic> json) {
  return _SessionEntity.fromJson(json);
}

/// @nodoc
mixin _$SessionEntity {
  int get amountOfSets => throw _privateConstructorUsedError;
  @JsonKey(toJson: SessionEntity.dateTimeToIsoString, fromJson: DateTime.parse)
  DateTime get dateAndTime => throw _privateConstructorUsedError;
  bool get startWithCold => throw _privateConstructorUsedError;
  int get coldIntervalSeconds => throw _privateConstructorUsedError;
  int get hotIntervalSeconds => throw _privateConstructorUsedError;

  /// Serializes this SessionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionEntityCopyWith<SessionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionEntityCopyWith<$Res> {
  factory $SessionEntityCopyWith(
          SessionEntity value, $Res Function(SessionEntity) then) =
      _$SessionEntityCopyWithImpl<$Res, SessionEntity>;
  @useResult
  $Res call(
      {int amountOfSets,
      @JsonKey(
          toJson: SessionEntity.dateTimeToIsoString, fromJson: DateTime.parse)
      DateTime dateAndTime,
      bool startWithCold,
      int coldIntervalSeconds,
      int hotIntervalSeconds});
}

/// @nodoc
class _$SessionEntityCopyWithImpl<$Res, $Val extends SessionEntity>
    implements $SessionEntityCopyWith<$Res> {
  _$SessionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amountOfSets = null,
    Object? dateAndTime = null,
    Object? startWithCold = null,
    Object? coldIntervalSeconds = null,
    Object? hotIntervalSeconds = null,
  }) {
    return _then(_value.copyWith(
      amountOfSets: null == amountOfSets
          ? _value.amountOfSets
          : amountOfSets // ignore: cast_nullable_to_non_nullable
              as int,
      dateAndTime: null == dateAndTime
          ? _value.dateAndTime
          : dateAndTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startWithCold: null == startWithCold
          ? _value.startWithCold
          : startWithCold // ignore: cast_nullable_to_non_nullable
              as bool,
      coldIntervalSeconds: null == coldIntervalSeconds
          ? _value.coldIntervalSeconds
          : coldIntervalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      hotIntervalSeconds: null == hotIntervalSeconds
          ? _value.hotIntervalSeconds
          : hotIntervalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionEntityImplCopyWith<$Res>
    implements $SessionEntityCopyWith<$Res> {
  factory _$$SessionEntityImplCopyWith(
          _$SessionEntityImpl value, $Res Function(_$SessionEntityImpl) then) =
      __$$SessionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int amountOfSets,
      @JsonKey(
          toJson: SessionEntity.dateTimeToIsoString, fromJson: DateTime.parse)
      DateTime dateAndTime,
      bool startWithCold,
      int coldIntervalSeconds,
      int hotIntervalSeconds});
}

/// @nodoc
class __$$SessionEntityImplCopyWithImpl<$Res>
    extends _$SessionEntityCopyWithImpl<$Res, _$SessionEntityImpl>
    implements _$$SessionEntityImplCopyWith<$Res> {
  __$$SessionEntityImplCopyWithImpl(
      _$SessionEntityImpl _value, $Res Function(_$SessionEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amountOfSets = null,
    Object? dateAndTime = null,
    Object? startWithCold = null,
    Object? coldIntervalSeconds = null,
    Object? hotIntervalSeconds = null,
  }) {
    return _then(_$SessionEntityImpl(
      amountOfSets: null == amountOfSets
          ? _value.amountOfSets
          : amountOfSets // ignore: cast_nullable_to_non_nullable
              as int,
      dateAndTime: null == dateAndTime
          ? _value.dateAndTime
          : dateAndTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startWithCold: null == startWithCold
          ? _value.startWithCold
          : startWithCold // ignore: cast_nullable_to_non_nullable
              as bool,
      coldIntervalSeconds: null == coldIntervalSeconds
          ? _value.coldIntervalSeconds
          : coldIntervalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      hotIntervalSeconds: null == hotIntervalSeconds
          ? _value.hotIntervalSeconds
          : hotIntervalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionEntityImpl implements _SessionEntity {
  const _$SessionEntityImpl(
      {required this.amountOfSets,
      @JsonKey(
          toJson: SessionEntity.dateTimeToIsoString, fromJson: DateTime.parse)
      required this.dateAndTime,
      required this.startWithCold,
      required this.coldIntervalSeconds,
      required this.hotIntervalSeconds});

  factory _$SessionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionEntityImplFromJson(json);

  @override
  final int amountOfSets;
  @override
  @JsonKey(toJson: SessionEntity.dateTimeToIsoString, fromJson: DateTime.parse)
  final DateTime dateAndTime;
  @override
  final bool startWithCold;
  @override
  final int coldIntervalSeconds;
  @override
  final int hotIntervalSeconds;

  @override
  String toString() {
    return 'SessionEntity(amountOfSets: $amountOfSets, dateAndTime: $dateAndTime, startWithCold: $startWithCold, coldIntervalSeconds: $coldIntervalSeconds, hotIntervalSeconds: $hotIntervalSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionEntityImpl &&
            (identical(other.amountOfSets, amountOfSets) ||
                other.amountOfSets == amountOfSets) &&
            (identical(other.dateAndTime, dateAndTime) ||
                other.dateAndTime == dateAndTime) &&
            (identical(other.startWithCold, startWithCold) ||
                other.startWithCold == startWithCold) &&
            (identical(other.coldIntervalSeconds, coldIntervalSeconds) ||
                other.coldIntervalSeconds == coldIntervalSeconds) &&
            (identical(other.hotIntervalSeconds, hotIntervalSeconds) ||
                other.hotIntervalSeconds == hotIntervalSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amountOfSets, dateAndTime,
      startWithCold, coldIntervalSeconds, hotIntervalSeconds);

  /// Create a copy of SessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionEntityImplCopyWith<_$SessionEntityImpl> get copyWith =>
      __$$SessionEntityImplCopyWithImpl<_$SessionEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionEntityImplToJson(
      this,
    );
  }
}

abstract class _SessionEntity implements SessionEntity {
  const factory _SessionEntity(
      {required final int amountOfSets,
      @JsonKey(
          toJson: SessionEntity.dateTimeToIsoString, fromJson: DateTime.parse)
      required final DateTime dateAndTime,
      required final bool startWithCold,
      required final int coldIntervalSeconds,
      required final int hotIntervalSeconds}) = _$SessionEntityImpl;

  factory _SessionEntity.fromJson(Map<String, dynamic> json) =
      _$SessionEntityImpl.fromJson;

  @override
  int get amountOfSets;
  @override
  @JsonKey(toJson: SessionEntity.dateTimeToIsoString, fromJson: DateTime.parse)
  DateTime get dateAndTime;
  @override
  bool get startWithCold;
  @override
  int get coldIntervalSeconds;
  @override
  int get hotIntervalSeconds;

  /// Create a copy of SessionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionEntityImplCopyWith<_$SessionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
