// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_preferences_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateSessionState {
  bool get startWithCold => throw _privateConstructorUsedError;
  int get numberOfSets => throw _privateConstructorUsedError;
  int get coldIntervalMinutes => throw _privateConstructorUsedError;
  int get hotIntervalMinutes => throw _privateConstructorUsedError;

  /// Create a copy of CreateSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateSessionStateCopyWith<CreateSessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSessionStateCopyWith<$Res> {
  factory $CreateSessionStateCopyWith(
          CreateSessionState value, $Res Function(CreateSessionState) then) =
      _$CreateSessionStateCopyWithImpl<$Res, CreateSessionState>;
  @useResult
  $Res call(
      {bool startWithCold,
      int numberOfSets,
      int coldIntervalMinutes,
      int hotIntervalMinutes});
}

/// @nodoc
class _$CreateSessionStateCopyWithImpl<$Res, $Val extends CreateSessionState>
    implements $CreateSessionStateCopyWith<$Res> {
  _$CreateSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startWithCold = null,
    Object? numberOfSets = null,
    Object? coldIntervalMinutes = null,
    Object? hotIntervalMinutes = null,
  }) {
    return _then(_value.copyWith(
      startWithCold: null == startWithCold
          ? _value.startWithCold
          : startWithCold // ignore: cast_nullable_to_non_nullable
              as bool,
      numberOfSets: null == numberOfSets
          ? _value.numberOfSets
          : numberOfSets // ignore: cast_nullable_to_non_nullable
              as int,
      coldIntervalMinutes: null == coldIntervalMinutes
          ? _value.coldIntervalMinutes
          : coldIntervalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      hotIntervalMinutes: null == hotIntervalMinutes
          ? _value.hotIntervalMinutes
          : hotIntervalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSessionStateImplCopyWith<$Res>
    implements $CreateSessionStateCopyWith<$Res> {
  factory _$$CreateSessionStateImplCopyWith(_$CreateSessionStateImpl value,
          $Res Function(_$CreateSessionStateImpl) then) =
      __$$CreateSessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool startWithCold,
      int numberOfSets,
      int coldIntervalMinutes,
      int hotIntervalMinutes});
}

/// @nodoc
class __$$CreateSessionStateImplCopyWithImpl<$Res>
    extends _$CreateSessionStateCopyWithImpl<$Res, _$CreateSessionStateImpl>
    implements _$$CreateSessionStateImplCopyWith<$Res> {
  __$$CreateSessionStateImplCopyWithImpl(_$CreateSessionStateImpl _value,
      $Res Function(_$CreateSessionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startWithCold = null,
    Object? numberOfSets = null,
    Object? coldIntervalMinutes = null,
    Object? hotIntervalMinutes = null,
  }) {
    return _then(_$CreateSessionStateImpl(
      startWithCold: null == startWithCold
          ? _value.startWithCold
          : startWithCold // ignore: cast_nullable_to_non_nullable
              as bool,
      numberOfSets: null == numberOfSets
          ? _value.numberOfSets
          : numberOfSets // ignore: cast_nullable_to_non_nullable
              as int,
      coldIntervalMinutes: null == coldIntervalMinutes
          ? _value.coldIntervalMinutes
          : coldIntervalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      hotIntervalMinutes: null == hotIntervalMinutes
          ? _value.hotIntervalMinutes
          : hotIntervalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CreateSessionStateImpl implements _CreateSessionState {
  const _$CreateSessionStateImpl(
      {this.startWithCold = true,
      this.numberOfSets = 3,
      this.coldIntervalMinutes = 1,
      this.hotIntervalMinutes = 1});

  @override
  @JsonKey()
  final bool startWithCold;
  @override
  @JsonKey()
  final int numberOfSets;
  @override
  @JsonKey()
  final int coldIntervalMinutes;
  @override
  @JsonKey()
  final int hotIntervalMinutes;

  @override
  String toString() {
    return 'CreateSessionState(startWithCold: $startWithCold, numberOfSets: $numberOfSets, coldIntervalMinutes: $coldIntervalMinutes, hotIntervalMinutes: $hotIntervalMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSessionStateImpl &&
            (identical(other.startWithCold, startWithCold) ||
                other.startWithCold == startWithCold) &&
            (identical(other.numberOfSets, numberOfSets) ||
                other.numberOfSets == numberOfSets) &&
            (identical(other.coldIntervalMinutes, coldIntervalMinutes) ||
                other.coldIntervalMinutes == coldIntervalMinutes) &&
            (identical(other.hotIntervalMinutes, hotIntervalMinutes) ||
                other.hotIntervalMinutes == hotIntervalMinutes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startWithCold, numberOfSets,
      coldIntervalMinutes, hotIntervalMinutes);

  /// Create a copy of CreateSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSessionStateImplCopyWith<_$CreateSessionStateImpl> get copyWith =>
      __$$CreateSessionStateImplCopyWithImpl<_$CreateSessionStateImpl>(
          this, _$identity);
}

abstract class _CreateSessionState implements CreateSessionState {
  const factory _CreateSessionState(
      {final bool startWithCold,
      final int numberOfSets,
      final int coldIntervalMinutes,
      final int hotIntervalMinutes}) = _$CreateSessionStateImpl;

  @override
  bool get startWithCold;
  @override
  int get numberOfSets;
  @override
  int get coldIntervalMinutes;
  @override
  int get hotIntervalMinutes;

  /// Create a copy of CreateSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateSessionStateImplCopyWith<_$CreateSessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
