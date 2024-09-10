// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_overview_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SessionOverviewState {
  CreateSessionState get createdSession => throw _privateConstructorUsedError;
  int get currentSet => throw _privateConstructorUsedError;
  int get secondsLeft => throw _privateConstructorUsedError;
  bool get finished => throw _privateConstructorUsedError;
  SessionState get sessionState => throw _privateConstructorUsedError;

  /// Create a copy of SessionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionOverviewStateCopyWith<SessionOverviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionOverviewStateCopyWith<$Res> {
  factory $SessionOverviewStateCopyWith(SessionOverviewState value,
          $Res Function(SessionOverviewState) then) =
      _$SessionOverviewStateCopyWithImpl<$Res, SessionOverviewState>;
  @useResult
  $Res call(
      {CreateSessionState createdSession,
      int currentSet,
      int secondsLeft,
      bool finished,
      SessionState sessionState});

  $CreateSessionStateCopyWith<$Res> get createdSession;
}

/// @nodoc
class _$SessionOverviewStateCopyWithImpl<$Res,
        $Val extends SessionOverviewState>
    implements $SessionOverviewStateCopyWith<$Res> {
  _$SessionOverviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdSession = null,
    Object? currentSet = null,
    Object? secondsLeft = null,
    Object? finished = null,
    Object? sessionState = null,
  }) {
    return _then(_value.copyWith(
      createdSession: null == createdSession
          ? _value.createdSession
          : createdSession // ignore: cast_nullable_to_non_nullable
              as CreateSessionState,
      currentSet: null == currentSet
          ? _value.currentSet
          : currentSet // ignore: cast_nullable_to_non_nullable
              as int,
      secondsLeft: null == secondsLeft
          ? _value.secondsLeft
          : secondsLeft // ignore: cast_nullable_to_non_nullable
              as int,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionState: null == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as SessionState,
    ) as $Val);
  }

  /// Create a copy of SessionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreateSessionStateCopyWith<$Res> get createdSession {
    return $CreateSessionStateCopyWith<$Res>(_value.createdSession, (value) {
      return _then(_value.copyWith(createdSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionOverviewStateImplCopyWith<$Res>
    implements $SessionOverviewStateCopyWith<$Res> {
  factory _$$SessionOverviewStateImplCopyWith(_$SessionOverviewStateImpl value,
          $Res Function(_$SessionOverviewStateImpl) then) =
      __$$SessionOverviewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CreateSessionState createdSession,
      int currentSet,
      int secondsLeft,
      bool finished,
      SessionState sessionState});

  @override
  $CreateSessionStateCopyWith<$Res> get createdSession;
}

/// @nodoc
class __$$SessionOverviewStateImplCopyWithImpl<$Res>
    extends _$SessionOverviewStateCopyWithImpl<$Res, _$SessionOverviewStateImpl>
    implements _$$SessionOverviewStateImplCopyWith<$Res> {
  __$$SessionOverviewStateImplCopyWithImpl(_$SessionOverviewStateImpl _value,
      $Res Function(_$SessionOverviewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdSession = null,
    Object? currentSet = null,
    Object? secondsLeft = null,
    Object? finished = null,
    Object? sessionState = null,
  }) {
    return _then(_$SessionOverviewStateImpl(
      createdSession: null == createdSession
          ? _value.createdSession
          : createdSession // ignore: cast_nullable_to_non_nullable
              as CreateSessionState,
      currentSet: null == currentSet
          ? _value.currentSet
          : currentSet // ignore: cast_nullable_to_non_nullable
              as int,
      secondsLeft: null == secondsLeft
          ? _value.secondsLeft
          : secondsLeft // ignore: cast_nullable_to_non_nullable
              as int,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionState: null == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as SessionState,
    ));
  }
}

/// @nodoc

class _$SessionOverviewStateImpl implements _SessionOverviewState {
  const _$SessionOverviewStateImpl(
      {required this.createdSession,
      this.currentSet = 1,
      required this.secondsLeft,
      this.finished = false,
      this.sessionState = SessionState.notStarted});

  @override
  final CreateSessionState createdSession;
  @override
  @JsonKey()
  final int currentSet;
  @override
  final int secondsLeft;
  @override
  @JsonKey()
  final bool finished;
  @override
  @JsonKey()
  final SessionState sessionState;

  @override
  String toString() {
    return 'SessionOverviewState(createdSession: $createdSession, currentSet: $currentSet, secondsLeft: $secondsLeft, finished: $finished, sessionState: $sessionState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionOverviewStateImpl &&
            (identical(other.createdSession, createdSession) ||
                other.createdSession == createdSession) &&
            (identical(other.currentSet, currentSet) ||
                other.currentSet == currentSet) &&
            (identical(other.secondsLeft, secondsLeft) ||
                other.secondsLeft == secondsLeft) &&
            (identical(other.finished, finished) ||
                other.finished == finished) &&
            (identical(other.sessionState, sessionState) ||
                other.sessionState == sessionState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, createdSession, currentSet,
      secondsLeft, finished, sessionState);

  /// Create a copy of SessionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionOverviewStateImplCopyWith<_$SessionOverviewStateImpl>
      get copyWith =>
          __$$SessionOverviewStateImplCopyWithImpl<_$SessionOverviewStateImpl>(
              this, _$identity);
}

abstract class _SessionOverviewState implements SessionOverviewState {
  const factory _SessionOverviewState(
      {required final CreateSessionState createdSession,
      final int currentSet,
      required final int secondsLeft,
      final bool finished,
      final SessionState sessionState}) = _$SessionOverviewStateImpl;

  @override
  CreateSessionState get createdSession;
  @override
  int get currentSet;
  @override
  int get secondsLeft;
  @override
  bool get finished;
  @override
  SessionState get sessionState;

  /// Create a copy of SessionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionOverviewStateImplCopyWith<_$SessionOverviewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
