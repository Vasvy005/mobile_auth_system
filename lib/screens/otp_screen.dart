import 'package:flutter/material.dart';
import 'package:mobile_auth_system/screens/home_screen.dart';
import 'package:mobile_auth_system/services/auth_service.dart';

class OTPScreen extends StatefulWidget {
  final String phoneOrEmail;

  const OTPScreen({super.key, required this.phoneOrEmail});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpController = TextEditingController();
  bool loading = false;

  void verifyOTP() async {
    setState(() => loading = true);
    final isValid = await AuthService().verifyFakeOTP(widget.phoneOrEmail, otpController.text.trim());
    setState(() => loading = false);

    if (isValid && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("OTP sent to ${widget.phoneOrEmail}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Enter OTP"),
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: verifyOTP,
                    child: const Text("Verify"),
                  ),
          ],
        ),
      ),
    );
  }
}
