import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_auth_system/services/auth_service.dart';

void main() {
  final auth = AuthService();

  group('OTP Authentication Tests', () {
    test('Correct OTP returns true', () async {
      final result = await auth.verifyFakeOTP('test@example.com', '123456');
      expect(result, true);
    });

    test('Incorrect OTP returns false', () async {
      final result = await auth.verifyFakeOTP('test@example.com', '000000');
      expect(result, false);
    });

    test('OTP send simulation returns true', () async {
      final result = await auth.sendFakeOTP('test@example.com');
      expect(result, true);
    });
  });
}
