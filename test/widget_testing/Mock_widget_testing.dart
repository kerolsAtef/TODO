import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/data/local/db.dart';
import 'package:to_do_app/data/remote/firebase.dart';
import 'package:to_do_app/data/remote/firestore_service.dart';
import 'package:to_do_app/domain/repositiories/todo_repository.dart';
import 'package:to_do_app/presentation/screens/login_page.dart';
import 'package:to_do_app/presentation/screens/main_page.dart';
import 'package:to_do_app/presentation/screens/insert_page.dart';
import 'package:to_do_app/presentation/screens/signup_page.dart';
import 'package:to_do_app/presentation/widgets/button.dart';
import 'package:to_do_app/presentation/widgets/text_input.dart';
import 'package:to_do_app/presentation/helpers.dart';
import 'package:mockito/mockito.dart';

// Mock AuthService for testing
class MockAuthService extends Mock {}

void main() {
  testWidgets('SignUpPage Widget Test', (WidgetTester tester) async {
    // Mock AuthService
    final authService = AuthService();

    // Build the SignUpPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: SignUpPage(),
        routes: {
          '/login': (context) => LoginPage(),
        },
      ),
    );

    // Verify the presence of key UI components
    expect(find.text(AppStrings.UserNameString), findsOneWidget);
    expect(find.text(AppStrings.EmailString), findsOneWidget);
    expect(find.text(AppStrings.PasswordString), findsOneWidget);
    expect(find.text(AppStrings.SignUpString), findsOneWidget);
    expect(find.text(AppStrings.LoginString), findsOneWidget);

    // Fill in the name, email, and password fields and tap the SignUp button
    await tester.enterText(find.byType(InputTextField).at(0), 'TestUser');
    await tester.enterText(find.byType(InputTextField).at(1), 'testemail@test.com');
    await tester.enterText(find.byType(InputTextField).at(2), 'testpassword');
    await tester.tap(find.byType(CustomButton));
    await tester.pumpAndSettle();

    // Use Mockito to handle the AuthService response
    when(authService.signUpWithEmailAndPassword('testemail@test.com', 'testpassword'))
        .thenAnswer((_) => Future.value()); // Replace 'User()' with the appropriate user object


  });

  testWidgets('MainPage Widget Test', (WidgetTester tester) async {
    // Mock dependencies and network connectivity
    final todoRepository = MockTodoRepository();
    final connectivity = MockConnectivity();
    when(connectivity.checkConnectivity()).thenAnswer((_) => Future.value(ConnectivityResult.wifi));
    when(todoRepository.getAllTodos()).thenAnswer((_) => Future.value([]));

    // Build the MainPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: MainPage(),
        routes: {
          '/login': (context) => LoginPage(),
        },
      ),
    );

    // Verify the presence of key UI components
    expect(find.text(AppStrings.MainPageHeaderString), findsOneWidget);
    expect(find.text(AppStrings.LoginString), findsOneWidget);

    // Verify that it loads the list of todos
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    // Verify that the list is displayed
    expect(find.byType(CheckboxListTile), findsWidgets);
  });

  testWidgets('InsertPage Widget Test', (WidgetTester tester) async {
    // Mock dependencies
    final firestoreService = MockFirestoreService();
    final localDatabase = MockLocalDatabase();

    // Build the InsertPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: InsertPage(),
      ),
    );

    // Verify the presence of key UI components
    expect(find.text(AppStrings.AddNewItemString), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);

    // Fill in the item text field and tap the Save button
    await tester.enterText(find.byType(InputTextField), 'New Task');
    await tester.tap(find.byType(CustomButton));
    await tester.pumpAndSettle();


  });
}

class MockTodoRepository extends Mock implements TodoRepository {}
class MockConnectivity extends Mock implements Connectivity {}
class MockFirestoreService extends Mock implements FirestoreService {}
class MockLocalDatabase extends Mock implements LocalDatabase {}
