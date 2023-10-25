import '../../data/remote/firebase.dart';

class LoginViewModel {
  final AuthService authService;

  LoginViewModel({required this.authService});

  // Login status to keep track of whether the login was successful.
  bool loginSuccessful = false;

  // Error message to display to the user in case of login failure.
  String errorMessage = '';

  // Function to handle user login with email and password.
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (!isValidEmail(email)) {
      errorMessage = 'Please enter a valid email address.';
      return;
    }

    try {
      final user = await authService.signInWithEmailAndPassword(email, password);

      if (user != null) {
        // Login successful
        loginSuccessful = true;
      } else {
        // Login failed
        loginSuccessful = false;
        errorMessage = 'Login failed. Please check your credentials.';
      }
    } catch (e) {
      // Handle login error
      loginSuccessful = false;
      errorMessage = 'An error occurred during login: $e';
    }
  }

  // Function to handle guest login.
  Future<void> signInAsGuest() async {
    try {
      final user = await authService.signInAnonymously();

      if (user != null) {
        // Guest login successful
        loginSuccessful = true;
      } else {
        // Guest login failed
        loginSuccessful = false;
        errorMessage = 'Guest login failed. Please try again.';
      }
    } catch (e) {
      // Handle guest login error
      loginSuccessful = false;
      errorMessage = 'An error occurred during guest login: $e';
    }
  }

  // Function to validate email format.
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }
}
