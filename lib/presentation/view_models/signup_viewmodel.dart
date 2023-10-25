import '../../data/remote/firebase.dart';

class SignupViewModel {
  final AuthService authService;

  SignupViewModel({required this.authService});

  // Registration status to keep track of whether the registration was successful.
  bool registrationSuccessful = false;

  // Error message to display to the user in case of registration failure.
  String errorMessage = '';

  // Function to handle user registration with email and password.
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    if (!isValidEmail(email)) {
      errorMessage = 'Please enter a valid email address.';
      return;
    }

    if (!isStrongPassword(password)) {
      errorMessage = 'Password must be at least 8 characters and include at least 1 number.';
      return;
    }

    try {
      final user = await authService.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        // Registration successful
        registrationSuccessful = true;
      } else {
        // Registration failed
        registrationSuccessful = false;
        errorMessage = 'Registration failed. Please try again.';
      }
    } catch (e) {
      // Handle registration error
      registrationSuccessful = false;
      errorMessage = 'An error occurred during registration: $e';
    }
  }

  // Function to validate email format.
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  // Function to check for strong password requirements.
  bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'\d'))) return false;
    return true;
  }
}
