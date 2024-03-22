import 'package:local_auth/local_auth.dart';

class LocalAuthUtil {
  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    print("Is device supported: $isBiometricSupported");
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    print("Can check biometrics: $canCheckBiometrics");

    bool isAuthenticated = false;

    final List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    print(availableBiometrics);

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
      );
    }

    return isAuthenticated;
  }

  Future<bool> isBiometricsAvailable() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    return isBiometricSupported && canCheckBiometrics;
  }
}
