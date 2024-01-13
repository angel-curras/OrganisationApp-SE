import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/app.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/todos/create_todo_dialog.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_courses_page_integration_test.dart';

void main() {
  setUp(() async {
    await setUpEnvironment();
  });

  testWidgets('Test Todo create and delete a task', (tester) async {
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await testPreferences.clear();

    // Start the app.
    await tester.pumpWidget(OrganisationApp(
      preferences: testPreferences,
    ));
    await tester.pumpAndSettle();

    // Login the user.
    String username = 'mathemann';
    await loginUser(tester, username);

    // navigate to todos page
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await pauseForVisualization(tester);
    // Expect the user name to be correct.
    expect(find.text('@$username'), findsOneWidget);
    await tester.tap(find.byKey(const Key('todosTile')));
    await tester.pumpAndSettle();
    expect(find.byType(TodosPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Expect 0 tasks to be present.
    expect(find.byType(Card), findsNothing);
    await pauseForVisualization(tester);

    // Tap the add button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(CreateItemPage), findsOneWidget);
    await pauseForVisualization(tester);
    await tester.enterText(find.byKey(const Key('name')), 'Test Task');
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    await tester.tap(find.byKey(const Key('deadline')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    await tester.tap(find.byKey(const Key('priority')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);

    // Expect 1 task to be present.
    expect(find.byType(Card), findsOneWidget);
    await pauseForVisualization(tester);

    // Tap the delete button.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);

    // Expect 0 tasks to be present.
    expect(find.byType(Card), findsNothing);
    await pauseForVisualization(tester);

    // Logout the user.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await pauseForVisualization(tester);
    // Expect the user name to be correct.
    expect(find.text('@$username'), findsOneWidget);
    await tester.tap(find.byKey(const Key('logoutTile')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    await pauseForVisualization(tester);
  });
}
