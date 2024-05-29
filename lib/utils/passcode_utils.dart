import 'package:ecommerce_app/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class PasscodeUtils {
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();
  Future<void> savePasscode({required String passcode}) async {
    await secureStorage.write(key: SharedPreferencesKeys.passcode, value: passcode);
  }

  Future<String?> getPasscode() async {
    final String? passcode = await secureStorage.read(key: SharedPreferencesKeys.passcode);
    return passcode;
  }

  Future<bool> hasPasscode() async {
    final String? passcode = await getPasscode();
    return passcode != null;
  }
}
