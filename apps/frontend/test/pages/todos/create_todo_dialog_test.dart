import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
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

  const MainTestApp(
      {super.key,
      required http.Client httpClient,
      required SharedPreferences preferences,
      required Task task,
      required bool edit})
      : _client = httpClient,
        _preferences = preferences,
        _task = task,
        _edit = edit;

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
            body: CreateItemPage(
              _client,
              _edit,
              task: _task,
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

  testWidgets('Test: Load empty dialog', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
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
}
