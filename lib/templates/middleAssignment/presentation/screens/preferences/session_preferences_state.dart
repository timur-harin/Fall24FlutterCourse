import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_preferences_state.freezed.dart';

@freezed
class CreateSessionState with _$CreateSessionState {
  const factory CreateSessionState({
    @Default(true) bool startWithCold,
    @Default(3) int numberOfSets,
    @Default(7) int coldIntervalSeconds,
    @Default(7) int hotIntervalSeconds,
  }) = _CreateSessionState;
}
