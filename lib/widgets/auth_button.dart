import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final IconData icon;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.icon,
  });

  factory AuthButton.google({required VoidCallback onPressed}) {
    return AuthButton(
      text: 'Continue with Google',
      onPressed: onPressed,
      color: Colors.red,
      icon: Icons.g_mobiledata,
    );
  }

  factory AuthButton.apple({required VoidCallback onPressed}) {
    if (!Platform.isIOS) {
      return const AuthButton(
        text: 'Apple Sign-In not available',
        onPressed: nullFunction,
        color: Colors.grey,
        icon: Icons.cancel,
      );
    }
    return AuthButton(
      text: 'Continue with Apple',
      onPressed: onPressed,
      color: Colors.black,
      icon: Icons.apple,
    );
  }

  static void nullFunction() {}

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
