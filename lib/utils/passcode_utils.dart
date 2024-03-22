import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class PasscodeUtils {
  Future<void> savePasscode({required String passcode}) async {
    await storage.write(key: 'passcode', value: passcode);
  }

  Future<String?> getPasscode() async {
    final String? passcode = await storage.read(key: "passcode");
    return passcode;
  }

  Future<bool> hasPasscode() async {
    final String? passcode = await getPasscode();
    return passcode != null;
  }
}
