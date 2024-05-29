import 'package:ecommerce_app/repositories/api_repositories/api_repositories.dart';
import 'package:ecommerce_app/repositories/cart_repository.dart'
    as firebaseRepos;
// import 'package:ecommerce_app/repositories/cart_repository.dart' as firebaseRepos;
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:get_it/get_it.dart';

class RepositoryDependencies {
  static Future<void> setUp(GetIt injector) async {
    injector.registerFactory<IAuthRepository>(() => AuthRepository());
    injector.registerFactory<IUserRepository>(() => UserRepository());
    injector
        .registerFactory<ICartRepository>(() => firebaseRepos.CartRepository());
    injector.registerFactory<IProductRepository>(() => ProductRepository());
    // injector.registerFactory<ICartRepository>(() => CartRepository(url: "wss://192.168.0.8:8082/ws"));
    // injector.registerFactory<ICartRepository>(() => firebaseRepos.CartRepository());
    injector.registerFactory<IProductRepository>(() => ProductRepository());
    injector.registerLazySingleton<ICartRepository>(
        () => CartRepository(url: "wss://192.168.0.8:8082/ws"));
  }
}
