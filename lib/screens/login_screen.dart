import 'package:flutter/material.dart';
import 'package:mobile_auth_system/screens/signup_screen.dart';
import 'package:mobile_auth_system/screens/home_screen.dart';
import 'package:mobile_auth_system/services/auth_service.dart';
import 'package:mobile_auth_system/widgets/auth_button.dart';
import 'package:mobile_auth_system/services/biometric_service.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricLogin();
  }

  Future<void> _checkBiometricLogin() async {
    final biometricSuccess = await BiometricService().authenticate();
    if (biometricSuccess) {
      final success = await auth.signInWithStoredToken();
      if (success && mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    }
  }

  void login() async {
    setState(() => loading = true);
    final success = await auth.signInWithEmail(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    setState(() => loading = false);

    if (success && mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: login,
                    child: const Text('Login'),
                  ),
            const SizedBox(height: 20),
            AuthButton.google(onPressed: auth.signInWithGoogle),
            const SizedBox(height: 10),
            AuthButton.apple(onPressed: auth.signInWithApple),
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignupScreen())),
              child: const Text("Don't have an account? Sign up"),
            ),
            TextButton(
              onPressed: () => auth.sendPasswordReset(emailController.text),
              child: const Text("Forgot Password?"),
            ),
          ],
        ),
      ),
    );
  }
}
