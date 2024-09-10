import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_preferences_state.freezed.dart';

@freezed
class CreateSessionState with _$CreateSessionState {
  const factory CreateSessionState({
    @Default(true) bool startWithCold,
    @Default(3) int numberOfSets,
    @Default(1) int coldIntervalMinutes,
    @Default(1) int hotIntervalMinutes,
  }) = _CreateSessionState;
}
