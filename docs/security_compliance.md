# Security Compliance Report

## Token Storage
- Tokens stored using `flutter_secure_storage`
- Uses Keychain (iOS) and Keystore (Android)

## Authentication
- Firebase Auth handles:
  - Token refresh
  - Secure email/password storage
  - OAuth 2.0 for Google/Apple

## Biometrics
- Biometric login via local_auth (Face ID / Fingerprint)
- No sensitive data stored locally

## GDPR/CCPA Alignment
- Firebase supports data export and deletion
- App should provide UI to request deletion (future enhancement)

## Future Recommendations
- Rate limiting (e.g., OTP resend)
- Password strength checker
- Consent prompt for analytics collection
