# Developer Onboarding Guide

## Prerequisites
- Flutter SDK (latest stable)
- Firebase CLI + project set up
- Android Studio or Xcode

## Getting Started
1. Clone repo
2. Add `google-services.json` (Android) & `GoogleService-Info.plist` (iOS)
3. Run: `flutter pub get`
4. Start emulator
5. Run: `flutter run`

## Firebase Setup
- Enable:
  - Email/Password Auth
  - Google Sign-In
  - Apple Sign-In (iOS)
  - Anonymous Auth (for OTP demo)

## Project Structure
- `screens/`: UI
- `services/`: Auth, token, biometric logic
- `widgets/`: Reusable buttons
- `test/`: Unit tests
- `docs/`: Documentation

## Common Tasks
- Login: Email/password, OTP, Google, Apple, Biometrics
- Reset Password: Type email and click "Forgot Password"
- Logout: Tap icon on top right of Home

## Notes
- Apple Sign-In only works on physical devices or macOS sim
- OTP is simulated ("123456")
- Biometric auth checks on app launch (if token exists)
