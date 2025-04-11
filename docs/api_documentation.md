# API Documentation - Mobile Auth System

## AuthService

### registerWithEmail(email, password)
- Creates user with Firebase
- Stores JWT via TokenService

### signInWithEmail(email, password)
- Logs user in with Firebase
- Retrieves and stores JWT

### signInWithGoogle()
- Initiates Google Sign-In flow
- Authenticates with Firebase
- Stores token

### signInWithApple()
- Initiates Apple Sign-In (iOS)
- Authenticates with Firebase
- Stores token

### sendFakeOTP(phoneOrEmail)
- Simulates OTP send

### verifyFakeOTP(phoneOrEmail, otp)
- Checks if OTP is "123456" (simulated)
- Logs in anonymously if correct

### sendPasswordReset(email)
- Sends Firebase password reset email

---

## TokenService

- `storeToken(token)` — saves JWT in secure storage
- `getToken()` — retrieves stored token
- `clearToken()` — deletes token

---

## BiometricService

- `authenticate()` — uses local_auth to validate biometrics
