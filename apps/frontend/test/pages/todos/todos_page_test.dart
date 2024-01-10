import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/task.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'todos_page_test.mocks.dart';

class MainTestAppTodosPage extends StatelessWidget {
  final http.Client _client;
  final SharedPreferences _preferences;

  const MainTestAppTodosPage(
      {super.key,
      required http.Client httpClient,
      required SharedPreferences preferences})
      : _client = httpClient,
        _preferences = preferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => AppSettings(_preferences)),
        ],
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: Scaffold(
            body: TodosPage(
              client: _client,
            ),
          ),
        ));
  }
}

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Test: Widget loads', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "test";
    final String requestUrl = '$apiUrl/tasks/$username';

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Define the mocked response.
    when(mockHttpClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response('[]', 200));

    // Build the widget tree.
    await tester.pumpWidget(
      MainTestAppTodosPage(
        httpClient: mockHttpClient,
        preferences: testPreferences,
      ),
    );
    expect(find.byType(TodosPage), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 200));
  });

  testWidgets('Test: Todo items are displayed and actions work',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Mock task data.
    final task1 = Task(
      id: 1,
      name: 'Task 1',
      priority: 2,
      deadline: DateTime(1, 1, 3000).add(Duration(days: 1)),
    );

    // Define the mocked response for getAllTasksForUser.
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('[${task1.toJsonString()}]', 200));

    // Define the mocked response.
    when(mockHttpClient.put(Uri.parse('${Environment.apiUrl}/tasks/1'),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response("{}", 200));

    when(mockHttpClient.delete(Uri.parse('${Environment.apiUrl}/tasks/1')))
        .thenAnswer((_) async => http.Response("{}", 200));

    // Build the widget tree.
    await tester.pumpWidget(
      MainTestAppTodosPage(
        httpClient: mockHttpClient,
        preferences: testPreferences,
      ),
    );

    // Wait for the FutureBuilder to complete.
    await tester.pumpAndSettle();

    // Verify the presence of task items.
    expect(find.byType(ListTile), findsNWidgets(1));

    // Verify the presence of checkboxes.
    expect(find.byType(Checkbox), findsNWidgets(1));

    // Verify the presence of edit and delete buttons.
    expect(find.byIcon(Icons.edit), findsNWidgets(1));
    expect(find.byIcon(Icons.delete), findsNWidgets(1));

    // Verify that the 'New' button exists.
    expect(find.byType(FloatingActionButton), findsOneWidget);

    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('doneCheckbox_0')));
    await tester.pumpAndSettle();
    // Tap on the checkbox of the first task.
    await tester.tap(find.byKey(const Key('doneCheckbox_0')));
    await tester.pumpAndSettle();

    await tester.pumpAndSettle();

    // Tap on the 'Edit' button.
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('save')));
    await tester.pumpAndSettle();

    // Tap on the 'Delete' button.
    await tester.tap(find.byIcon(Icons.delete).at(0));
    await tester.pumpAndSettle();
  });

  testWidgets('Test: Create new task', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Define the mocked response for getAllTasksForUser.
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('[]', 200));

    // Define the mocked response.
    when(mockHttpClient.post(Uri.parse('${Environment.apiUrl}/tasks/test'),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response("{}", 200));

    // Build the widget tree.
    await tester.pumpWidget(
      MainTestAppTodosPage(
        httpClient: mockHttpClient,
        preferences: testPreferences,
      ),
    );
    await tester.pumpAndSettle();

    // Tap on the 'New' button.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Enter the task name.
    await tester.enterText(find.byKey(const Key('name')), 'New Task');
    await tester.pumpAndSettle();

    // Tap on the 'Save' button.
    await tester.tap(find.byKey(const Key('save')));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 10000));
  });

  testWidgets('Test: Delete task', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Mock task data.
    final task1 = Task(
      id: 1,
      name: 'Task 1',
      priority: 2,
      deadline: DateTime(1, 1, 3000).add(Duration(days: 1)),
    );

    // Define the mocked response for getAllTasksForUser.
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('[${task1.toJsonString()}]', 200));

    // Define the mocked response.
    when(mockHttpClient.put(Uri.parse('${Environment.apiUrl}/tasks/1'),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response("{}", 200));

    when(mockHttpClient.delete(Uri.parse('${Environment.apiUrl}/tasks/1')))
        .thenAnswer((_) async => http.Response("{}", 200));

    // Build the widget tree.
    await tester.pumpWidget(
      MainTestAppTodosPage(
        httpClient: mockHttpClient,
        preferences: testPreferences,
      ),
    );
    await tester.pumpAndSettle();

    // Tap on the 'Delete' button.
    await tester.tap(find.byIcon(Icons.delete).at(0));
    await tester.pumpAndSettle();
  });

  // done checkbox test whit 3 task whit difertent prioritys
  testWidgets('Test: done checkbox', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Mock task data.
    final task1 = Task(
      id: 1,
      name: 'Task 1',
      priority: 1,
      deadline: DateTime(1, 1, 3000).add(Duration(days: 1)),
    );
    final task2 = Task(
      id: 2,
      name: 'Task 2',
      priority: 2,
      deadline: DateTime(1, 1, 3000).add(Duration(days: 1)),
    );
    final task3 = Task(
      id: 3,
      name: 'Task 3',
      priority: 3,
      deadline: DateTime(1, 1, 3000).add(Duration(days: 1)),
    );

    // Define the mocked response for getAllTasksForUser.
    when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
        '[${task1.toJsonString()},${task2.toJsonString()},${task3.toJsonString()}]',
        200));

    // Define the mocked response for task 1.
    when(mockHttpClient.put(Uri.parse('${Environment.apiUrl}/tasks/1'),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response("{}", 200));

    // Define the mocked response for task 2.
    when(mockHttpClient.put(Uri.parse('${Environment.apiUrl}/tasks/2'),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response("{}", 200));

    // Define the mocked response for task 3.
    when(mockHttpClient.put(Uri.parse('${Environment.apiUrl}/tasks/3'),
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response("{}", 200));

    // Build the widget tree.
    await tester.pumpWidget(
      MainTestAppTodosPage(
        httpClient: mockHttpClient,
        preferences: testPreferences,
      ),
    );
    await tester.pumpAndSettle();

    // Tap on the 'checkbox' button.
    await tester.tap(find.byKey(const Key('doneCheckbox_0')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('doneCheckbox_1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('doneCheckbox_2')));
    await tester.pumpAndSettle();
  });
}
