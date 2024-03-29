import 'package:get_it/get_it.dart';
import 'package:team_manager/environment_config.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';
import 'package:team_manager/service/firebase_storage_service.dart';
import 'package:team_manager/service/navigation_service.dart';
import 'package:team_manager/service/toast_service.dart';
import 'package:team_manager/service/user_connected_service.dart';

class InjectionDependencies {
  static void injectDependencies() {
    GetIt.I.registerSingleton(
        (ApiClient(basePath: (EnvironmentConfig.useHttps ? 'https://' : 'http://') + EnvironmentConfig.serverUrl)));

    GetIt.I.registerLazySingleton(() {
      final ApiClient apiClient = GetIt.I.get();
      return JwtControllerApi(apiClient);
    });

    GetIt.I.registerSingleton(UserConnectedService());

    GetIt.I.registerSingleton(NavigationService());

    GetIt.I.registerSingleton(FirebaseStorageService());

    GetIt.I.registerSingleton(FirebaseAuthenticationService());

    GetIt.I.registerSingletonAsync(() => Future.value(ToastService()));

    GetIt.I.registerLazySingleton(() {
      final ApiClient apiClient = GetIt.I.get();
      return PlanningControllerApi(apiClient);
    });

    GetIt.I.registerLazySingleton(() {
      final ApiClient apiClient = GetIt.I.get();
      return TeammateControllerApi(apiClient);
    });

    GetIt.I.registerLazySingleton(() {
      final ApiClient apiClient = GetIt.I.get();
      return DashboardControllerApi(apiClient);
    });

    GetIt.I.registerLazySingleton(() {
      final ApiClient apiClient = GetIt.I.get();
      return CongesControllerApi(apiClient);
    });

    GetIt.I.registerLazySingleton(() {
      final ApiClient apiClient = GetIt.I.get();
      return CompetenceControllerApi(apiClient);
    });
  }
}
