import 'package:ecommerce_app/dependencies/page_dependencies.dart';
import 'package:ecommerce_app/dependencies/repository_dependencies.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDependencies {
  static GetIt get injector => GetIt.instance;

  static Future<void> init() async {
    // Init secure storage
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );
    injector.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage(aOptions: androidOptions));

    // Init Shared Preferences
    final sharedPreferences = await SharedPreferences.getInstance();
    injector.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    await PageDependencies.setUp(injector);
    await RepositoryDependencies.setUp(injector);
  }
}
