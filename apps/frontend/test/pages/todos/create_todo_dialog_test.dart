import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/task.dart';
import 'package:organisation_app/pages/todos/create_todo_dialog.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_todo_dialog_test.mocks.dart';

class MainTestApp extends StatelessWidget {
  final http.Client _client;
  final SharedPreferences _preferences;
  final Task _task;
  final bool _edit;

  const MainTestApp({
    Key? key,
    required http.Client httpClient,
    required SharedPreferences preferences,
    required Task task,
    required bool edit,
  })  : _client = httpClient,
        _preferences = preferences,
        _task = task,
        _edit = edit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppSettings(_preferences),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: Scaffold(
          body: CreateItemPage(
            _client,
            _edit,
            task: _task,
          ),
        ),
      ),
    );
  }
}

@GenerateMocks([http.Client])
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUp(() async {
    await setUpEnvironment();
  });

  testWidgets('Test: Load empty dialog', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    final mockHttpClient = MockClient();
    Task task = Task();
    bool edit = false;

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      task: task,
      edit: edit,
    ));
    expect(find.byType(CreateItemPage), findsOneWidget);
  });

  testWidgets('Test: Edit existing task', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    final mockHttpClient = MockClient();
    Task task = Task(
      id: 1,
      name: 'Existing Task',
      priority: 2,
      deadline: DateTime.now().add(const Duration(days: 1)),
    );

    bool edit = true;

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      task: task,
      edit: edit,
    ));

    expect(find.text('Existing Task'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Pick a date'), findsOneWidget);
    expect(find.text('New Task'), findsNothing);

    await tester.enterText(find.byKey(const Key('name')), 'Updated Task');
    await tester.pump();

    expect(find.text('Updated Task'), findsOneWidget);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(milliseconds: 10000));
  });

  testWidgets('Test: Create new task', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    final mockHttpClient = MockClient();
    bool edit = false;

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      task: Task(),
      edit: edit,
    ));

    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response("{}", 200));

    expect(find.text('Save'), findsOneWidget);
    expect(find.text('New Task'), findsNothing);

    await tester.enterText(find.byKey(const Key('name')), 'New Task');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('priority')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('deadline')));
    await tester.pumpAndSettle();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("save")));
    await tester.pumpAndSettle();

    expect(find.byType(CreateItemPage), findsNothing);
  });

  testWidgets('Test: Validate empty form submission', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    final mockHttpClient = MockClient();
    bool edit = false;

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      task: Task(),
      edit: edit,
    ));

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Error: please enter Task name'), findsOneWidget);
  });
}
