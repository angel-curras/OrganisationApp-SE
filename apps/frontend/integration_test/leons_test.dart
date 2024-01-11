import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/app/app.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/my_courses/my_courses_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    await setUpEnvironment();
  });
  testWidgets('Test Modules Sorting, Search, Add modules to my courses',
      (tester) async {
    // Clear the shared preferences to start the test.
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await testPreferences.clear();

    await tester.pumpWidget(OrganisationApp(
      preferences: testPreferences,
    ));

    await tester.pumpAndSettle();

    // Find a button with the text "Continue as Guest"
    expect(find.text('Continue as Guest'), findsOneWidget);

    // Tap the button
    String username = 'test';
    expect(find.byType(LoginPage), findsOneWidget);

    // Enter the username.
    await tester.enterText(
        find.byKey(const Key('usernameTextField')), username);

    // Tap the login button.
    await tester.tap(find.byKey(const Key('loginButton')));

    // Wait for the login to complete.
    await tester.pumpAndSettle();

    // Check that the user is logged in.
    expect(find.byType(MyCoursesPage), findsOneWidget);

    // Rebuild the widget after the state has changed.
    await tester.pumpAndSettle();

    // Click on menu drawer
    await tester.tap(find.byIcon(Icons.menu));

    // Rebuild the widget after the state has changed.
    await tester.pumpAndSettle();

    // Verify that the drawer is open
    expect(find.text('Modules'), findsOneWidget);

    // Tap the Modules button
    await tester.tap(find.text('Modules'));
    await tester.pumpAndSettle();

    // Verify that the Modules page is displayed by looking for first module
    expect(find.text('3D-Szenengenerierung'), findsOneWidget);

    // Test sorting
    // Tap the sort button
    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();

    // Tap the Ascending toggle by tapping on Ascending
    await tester.tap(find.text('Ascending'));
    await tester.pumpAndSettle();

    // Verify that the Modules page is displayed by looking for first module
    expect(find.text('Ökonomie in der IT-Sicherheit'), findsOneWidget);

    // Scroll down
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    // Tap 'Load More'
    await tester.tap(find.text('Load More'));
    await tester.pumpAndSettle();

    // Scroll down
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    // Verify that the Modules page is displayed by looking for search button
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Tap the Search button
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Write something in the search field
    await tester.enterText(find.byType(TextField), 'Software Engineering');
    await tester.pumpAndSettle();

    // Find a card with the text "Software Engineering"
    expect(find.text('Software Engineering'), findsOneWidget);
    await tester.pumpAndSettle();

    // Tap the card
    await tester.tap(find.text('Software Engineering I'));
    await tester.pumpAndSettle();

    // Find action button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Tap the arrow back
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Tap the Search button
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Write something in the search field
    await tester.enterText(find.byType(TextField), 'Högele');
    await tester.pumpAndSettle();

    // Find a card with the text "Software Engineering"
    expect(find.text('Analysis'), findsOneWidget);
    await tester.pumpAndSettle();

    // Tap the card
    await tester.tap(find.text('Analysis'));
    await tester.pumpAndSettle();

    // Find action button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Tap the arrow back
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Click on menu drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Tap the Courses button
    await tester.tap(find.text('My Courses'));
    await tester.pumpAndSettle();

    // Expect two Courses
    expect(find.text('Software Engineering I'), findsOneWidget);
    expect(find.text('Analysis'), findsOneWidget);

    // Click on menu drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the drawer is open
    expect(find.text('Modules'), findsOneWidget);

    // Tap the Moodle button
    await tester.tap(find.text('Moodle'));
    await tester.pumpAndSettle();

    // Click on menu drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the drawer is open
    expect(find.text('Modules'), findsOneWidget);

    // Tap the Primuss button
    await tester.tap(find.text('Primuss'));
    await tester.pumpAndSettle();

    // Click on menu drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the drawer is open
    expect(find.text('Modules'), findsOneWidget);

    // Tap the ChatGPT button
    await tester.tap(find.text('ChatGPT'));
    await tester.pumpAndSettle();

    // Click on menu drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the drawer is open
    expect(find.text('Modules'), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    // Find a button with the text "Continue as Guest"
    expect(find.text('Continue as Guest'), findsOneWidget);
  });
}
