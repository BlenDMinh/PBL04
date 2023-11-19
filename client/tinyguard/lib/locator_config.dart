import 'package:get_it/get_it.dart';
import 'package:tinyguard/data/datasource/remote/api/api_client.dart';
import 'package:tinyguard/data/datasource/remote/service/auth_api_service.dart';
import 'package:tinyguard/data/repository/user_repository.dart';
import 'package:tinyguard/data/shared_preferences/spref_auth_model.dart';
import 'package:tinyguard/view_models/log_in_view_model.dart';

GetIt getIt = GetIt.instance;

void setupLocator() async {
  await SPrefAuthModel().onInit();
  getIt.registerSingleton<AuthAPIService>(
      AuthAPIService(client: APIClient(sPref: SPrefAuthModel())));
  getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(authAPIService: getIt.get<AuthAPIService>()));
  getIt.registerLazySingleton<LogInViewModel>(() => LogInViewModel(
      userRepository: getIt.get<UserRepository>(), sPref: SPrefAuthModel()));
}