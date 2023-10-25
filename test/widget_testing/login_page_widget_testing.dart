import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/data/remote/firebase.dart';
import 'package:to_do_app/presentation/screens/login_page.dart'; // Import your LoginPage class
import 'package:to_do_app/presentation/screens/main_page.dart'; // Import your MainPage class
import 'package:to_do_app/presentation/screens/signup_page.dart'; // Import your SignUpPage class
import 'package:to_do_app/presentation/widgets/button.dart'; // Import your CustomButton widget
import 'package:to_do_app/presentation/widgets/text_input.dart'; // Import your InputTextField widget
import 'package:to_do_app/presentation/helpers.dart';
import 'package:mockito/mockito.dart';

// Mock AuthService for testing
class MockAuthService extends Mock {}

void main() {
  testWidgets('LoginPage Widget Test', (WidgetTester tester) async {
    // Mock AuthService
    final authService = AuthService();

    // Build the LoginPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
        routes: {
          '/main': (context) => MainPage(),
          '/signup': (context) => SignUpPage(),
        },
      ),
    );

    // Verify the presence of key UI components
    expect(find.text(AppStrings.EmailString), findsOneWidget);
    expect(find.text(AppStrings.PasswordString), findsOneWidget);
    expect(find.text(AppStrings.LoginString), findsOneWidget);
    expect(find.text(AppStrings.SignUpString), findsOneWidget);
    expect(find.text(AppStrings.GuestString), findsOneWidget);

    // Fill in the email and password fields and tap the Login button
    await tester.enterText(find.byType(InputTextField).at(0), 'testemail@test.com');
    await tester.enterText(find.byType(InputTextField).at(1), 'testpassword');
    await tester.tap(find.byType(CustomButton));
    await tester.pumpAndSettle();

    // Use Mockito to handle the AuthService response
    when(authService.signInWithEmailAndPassword('testemail@test.com', 'testpassword'))
        .thenAnswer((_) => Future.value()); // Replace 'User()' with the appropriate user object

  });
}
