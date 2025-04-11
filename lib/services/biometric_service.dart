import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final canCheck = await auth.canCheckBiometrics;
      final isAvailable = await auth.isDeviceSupported();
      if (!canCheck || !isAvailable) return false;

      final didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return didAuthenticate;
    } catch (e) {
      print("Biometric error: $e");
      return false;
    }
  }
}
