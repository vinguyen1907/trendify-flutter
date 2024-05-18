import 'package:ecommerce_app/repositories/api_repositories/api_repositories.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:get_it/get_it.dart';

class RepositoryDependencies {
  static Future<void> setUp(GetIt injector) async {
    injector.registerFactory<IAuthRepository>(() => AuthRepository());
    injector.registerFactory<IUserRepository>(() => UserRepository());
  }
}
