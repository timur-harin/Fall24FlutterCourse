// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeScreenState {
  List<SessionEntity> get sessions => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeScreenStateCopyWith<HomeScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenStateCopyWith<$Res> {
  factory $HomeScreenStateCopyWith(
          HomeScreenState value, $Res Function(HomeScreenState) then) =
      _$HomeScreenStateCopyWithImpl<$Res, HomeScreenState>;
  @useResult
  $Res call({List<SessionEntity> sessions, bool loading});
}

/// @nodoc
class _$HomeScreenStateCopyWithImpl<$Res, $Val extends HomeScreenState>
    implements $HomeScreenStateCopyWith<$Res> {
  _$HomeScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessions = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      sessions: null == sessions
          ? _value.sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<SessionEntity>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeScreenStateImplCopyWith<$Res>
    implements $HomeScreenStateCopyWith<$Res> {
  factory _$$HomeScreenStateImplCopyWith(_$HomeScreenStateImpl value,
          $Res Function(_$HomeScreenStateImpl) then) =
      __$$HomeScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SessionEntity> sessions, bool loading});
}

/// @nodoc
class __$$HomeScreenStateImplCopyWithImpl<$Res>
    extends _$HomeScreenStateCopyWithImpl<$Res, _$HomeScreenStateImpl>
    implements _$$HomeScreenStateImplCopyWith<$Res> {
  __$$HomeScreenStateImplCopyWithImpl(
      _$HomeScreenStateImpl _value, $Res Function(_$HomeScreenStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessions = null,
    Object? loading = null,
  }) {
    return _then(_$HomeScreenStateImpl(
      sessions: null == sessions
          ? _value._sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<SessionEntity>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HomeScreenStateImpl implements _HomeScreenState {
  const _$HomeScreenStateImpl(
      {final List<SessionEntity> sessions = const [], this.loading = true})
      : _sessions = sessions;

  final List<SessionEntity> _sessions;
  @override
  @JsonKey()
  List<SessionEntity> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'HomeScreenState(sessions: $sessions, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeScreenStateImpl &&
            const DeepCollectionEquality().equals(other._sessions, _sessions) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_sessions), loading);

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeScreenStateImplCopyWith<_$HomeScreenStateImpl> get copyWith =>
      __$$HomeScreenStateImplCopyWithImpl<_$HomeScreenStateImpl>(
          this, _$identity);
}

abstract class _HomeScreenState implements HomeScreenState {
  const factory _HomeScreenState(
      {final List<SessionEntity> sessions,
      final bool loading}) = _$HomeScreenStateImpl;

  @override
  List<SessionEntity> get sessions;
  @override
  bool get loading;

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeScreenStateImplCopyWith<_$HomeScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
