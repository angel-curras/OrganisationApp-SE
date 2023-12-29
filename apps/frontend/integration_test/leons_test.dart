import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // end of setUp()

  group("Login button", () {
    setUp(() async {});

    testWidgets('tap on the login as guest button', (tester) async {
      SharedPreferences testPreferences = await SharedPreferences.getInstance();
      await tester.pumpWidget(OrganisationApp(
        preferences: testPreferences,
      ));

      await tester.pumpAndSettle();

      // Find a button with the text "Continue as Guest"
      expect(find.text('Continue as Guest'), findsOneWidget);
    });
  });
}
