import 'package:fall_24_flutter_course/templates/middleAssignment/domain/session_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_state.freezed.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    @Default([]) List<SessionEntity> sessions,
    @Default(true) bool loading,
  }) = _HomeScreenState;

  factory HomeScreenState.loading() => const HomeScreenState(
        loading: true,
        sessions: [],
      );

  factory HomeScreenState.loaded(List<SessionEntity> sessions) =>
      HomeScreenState(
        loading: false,
        sessions: sessions,
      );
}
