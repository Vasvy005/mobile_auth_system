import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:mobile_auth_system/services/token_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Email/password registration
  Future<bool> registerWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await TokenService.storeToken(await credential.user?.getIdToken() ?? '');
      return true;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  // Email/password login
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await TokenService.storeToken(await credential.user?.getIdToken() ?? '');
      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Google sign-in
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);
      await TokenService.storeToken(await userCred.user?.getIdToken() ?? '');
    } catch (e) {
      print('Google Sign-In error: $e');
    }
  }

  // Apple sign-in (iOS only)
  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userCred = await _auth.signInWithCredential(oauthCredential);
      await TokenService.storeToken(await userCred.user?.getIdToken() ?? '');
    } catch (e) {
      print('Apple Sign-In error: $e');
    }
  }

  // Forgot password
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Password reset error: $e');
    }
  }

  // OTP login (simulated for demo)
  Future<bool> sendFakeOTP(String phoneOrEmail) async {
    // In production: Send actual OTP via Twilio, Firebase, etc.
    print("Sending fake OTP to $phoneOrEmail...");
    return true;
  }

  Future<bool> verifyFakeOTP(String phoneOrEmail, String otp) async {
    // Simulate OTP verification (correct OTP = 123456)
    if (otp == "123456") {
      // Simulate login
      final anon = await _auth.signInAnonymously();
      await TokenService.storeToken(await anon.user?.getIdToken() ?? '');
      return true;
    }
    return false;
  }

  // Token-based login from secure storage
  Future<bool> signInWithStoredToken() async {
    try {
      final token = await TokenService.getToken();
      if (token == null) return false;

      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        return true;
      }

      // Token refresh (Firebase auto refreshes if user still logged in)
      return true;
    } catch (e) {
      print('Token login error: $e');
      return false;
    }
  }
}
