import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Tap on the login as guest button', (tester) async {
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(OrganisationApp(
      preferences: testPreferences,
    ));

    await tester.pumpAndSettle();

    // Find a button with the text "Continue as Guest"
    expect(find.text('Continue as Guest'), findsOneWidget);

    // Tap on the button
    await tester.tap(find.text('Continue as Guest'));

    // Wait for the page to load
    await tester.pumpAndSettle();

    // // Check if the page has loaded
    // expect(find.text('My Courses'), findsOneWidget);
  });
}
