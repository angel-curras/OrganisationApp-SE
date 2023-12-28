import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/app.dart';

void main() {
  testWidgets('tap on the login as guest button', (tester) async {
    await tester.pumpWidget(const OrganisationApp());

    await tester.pumpAndSettle();

    // Find a button with the text "Continue as Guest"
    expect(find.text('Continue as Guest'), findsOneWidget);
  });
}
