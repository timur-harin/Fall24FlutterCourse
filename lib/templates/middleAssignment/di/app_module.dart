import 'package:fall_24_flutter_course/templates/middleAssignment/data/shower_sessions_repository_impl.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/domain/shower_sessions_repository.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/home/di/home_module.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/session/di/session_module.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/session_preferences/di/preferences_module.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/ui/theme/theme.dart';
import 'package:get_it/get_it.dart';

void registerAppModule() =>
    GetIt.instance
          ..registerLazySingleton<AppTheme>(() => AppTheme())
          ..registerLazySingleton<ShowerSessionRepository>(() => ShowerSessionsRepositoryImpl())
          ..registerHomeModule()
          ..registerPreferencesModule()
          ..registerSessionModule();
