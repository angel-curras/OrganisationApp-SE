import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/app.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/modules/module_details_page.dart';
import 'package:organisation_app/pages/modules/modules_list.dart';
import 'package:organisation_app/pages/my_courses/my_courses_page.dart';
import 'package:organisation_app/pages/my_courses/update_course_dialog.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginUser(tester, username) async {
  // Expect the login page to be shown.
  expect(find.byType(LoginPage), findsOneWidget);

  // Enter the username.
  await tester.enterText(find.byKey(const Key('usernameTextField')), username);

  // Tap the login button.
  await tester.tap(find.byKey(const Key('loginButton')));

  // Wait for the login to complete.
  await tester.pumpAndSettle();
  await pauseForVisualization(tester);

  // Check that the user is logged in.
  expect(find.byType(MyCoursesPage), findsOneWidget);
} // end of loginUser()

Future<void> pauseForVisualization(tester, {int durationSecs = 1}) async {
  // Wait to visualize the test better.
  await tester.pump(Duration(seconds: durationSecs));
} // end of pauseTester()

void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Login user, create, edit and delete a course.', (tester) async {
    // Do not forget to start the backend before running this test.
    // Tested on the windows platform.

    // Clear the shared preferences to start the test.
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await testPreferences.clear();

    // Start the app.
    await tester.pumpWidget(OrganisationApp(
      preferences: testPreferences,
    ));
    await tester.pumpAndSettle();

    // Login the user.
    String username = 'acurrass';
    await loginUser(tester, username);

    // Check that the courses are empty.
    expect(find.byType(Card), findsNothing);

    // Navigate to the tasks.
    // Tap the "Todos" button.
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

    // Go back to the home page.
    // Tap the "My Courses" button.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await pauseForVisualization(tester);
    await tester.tap(find.byKey(const Key('homeTile')));
    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Tap the add course button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);

    // Wait to navigate to the modules page.
    expect(find.byType(CoursesPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Expect more than 0 modules to be present.
    expect(find.byType(Card), findsWidgets);
    await pauseForVisualization(tester);

    // Tap the first module.
    await tester.tap(find.byType(Card).first);

    // Wait to navigate to the details page.
    await tester.pumpAndSettle();
    expect(find.byType(ModuleDetailsPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Tap the enroll button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Expect the user to be in the modules page.
    expect(find.byType(CoursesPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Navigate to the my courses page.
    // Open the drawer.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await pauseForVisualization(tester);

    // Tap the "My Courses" button.
    await tester.tap(find.byKey(const Key('homeTile')));
    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Expect a course to be present.
    expect(find.byType(Card), findsWidgets);
    await pauseForVisualization(tester);

    // Tap the first course.
    await tester.tap(find.byType(Card).first);
    await tester.pumpAndSettle();

    // Expect a dialog to pop up.
    expect(find.byType(UpdateCourseDialog), findsWidgets);
    await pauseForVisualization(tester);

    // Enter the course start date.
    await tester.tap(find.byKey(const Key('startDateButton')));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    // Select the first day of the month.
    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);

    // Enter the course end date.
    await tester.tap(find.byKey(const Key('endDateButton')));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    // Select a week later.
    await tester.tap(find.text('8'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);

    // Select the lecture day.
    await tester.tap(find.byKey(const Key('lectureWeekDayDropdownButton')));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    await tester.tap(find.text('MONDAY'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);

    // Select the lecture start time.
    await tester.tap(find.byKey(const Key('lectureStartTimeButton')));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    // Set up time
    await pauseForVisualization(tester);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);

    // Select the end time.
    await tester.tap(find.byKey(const Key('lectureEndTimeButton')));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);
    // Set up time
    await pauseForVisualization(tester);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await pauseForVisualization(tester);

    // Tap the save button.
    // Scroll until the widget is visible.
    await tester.dragUntilVisible(
        find.byKey(const Key("lectureEndTimeButton")), // what you want to find
        find.byType(ListView),
        // widget you want to scroll
        const Offset(0, 500) // delta to move
        );

    // Save and go back.
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("updateButton")));
    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Navigate to the tasks.
    // Tap the "Todos" button.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await pauseForVisualization(tester);
    await tester.tap(find.byKey(const Key('todosTile')));
    await tester.pumpAndSettle();
    expect(find.byType(TodosPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Expect tasks to be present.
    expect(find.byType(Card), findsWidgets);
    await pauseForVisualization(tester);

    // Go back to the home page.
    // Tap the "My Courses" button.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await pauseForVisualization(tester);
    await tester.tap(find.byKey(const Key('homeTile')));
    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Tap the delete button.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Expect the course to be deleted.
    expect(find.byType(Card), findsNothing);
    await pauseForVisualization(tester);

    // Navigate to the tasks
    // Tap the "Todos" button.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await pauseForVisualization(tester);
    await tester.tap(find.byKey(const Key('todosTile')));
    await tester.pumpAndSettle();
    expect(find.byType(TodosPage), findsOneWidget);
    await pauseForVisualization(tester);

    // Expect 0 tasks to be present.
    expect(find.byType(Card), findsNothing);
    await pauseForVisualization(tester);
  }); // end of integration test: Login user, create edit and delete a course.

  testWidgets('Login valid user and then logout.', (tester) async {
    // Do not forget to start the backend before running this test.

    // Clear the shared preferences to start the test.
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await testPreferences.clear();

    // Start the app.
    await tester.pumpWidget(OrganisationApp(
      preferences: testPreferences,
    ));
    await tester.pumpAndSettle();

    // Login the user.
    String username = 'test';
    await loginUser(tester, username);

    // Check that the courses are empty.
    expect(find.byType(Card), findsNothing);

    // Navigate to the my courses page.
    // Open the drawer.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);
    await pauseForVisualization(tester);

    // Expect the user name to be correct.
    expect(find.text('@$username'), findsOneWidget);

    // Tap the "My Courses" button.
    await tester.tap(find.byKey(const Key('logoutTile')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    await pauseForVisualization(tester);
  }); // end of integration test: Login valid user and then logout.
} // end of main()
