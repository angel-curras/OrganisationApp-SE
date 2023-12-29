import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/my_courses/my_courses_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page_test.mocks.dart';

class MainTestAppLoginPage extends StatelessWidget {
  final SharedPreferences _preferences;
  final http.Client _client;

  const MainTestAppLoginPage(
      {super.key,
      required SharedPreferences preferences,
      required http.Client client})
      : _preferences = preferences,
        _client = client;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppSettings(_preferences))
        ],
        child: MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
            ),
            routes: appRoutes,
            home: LoginPage(
              client: _client,
            )));
  }
}

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Test: Initialize widgets', (tester) async {
    // Mock the SharedPreferences.
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Test the initial state.
    await tester.pumpWidget(MainTestAppLoginPage(
      preferences: testPreferences,
      client: MockClient(),
    ));

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Center), findsNWidgets(3));
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(9));
    expect(find.byType(Image), findsNWidgets(2));
  });

  testWidgets('Test: Login with valid username', (tester) async {
    // Mock the SharedPreferences.
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Mock the http.Client.
    var mockClient = MockClient();

    // Mock the response from the server.
    AppUser user = AppUser(
        userName: "test", fullName: "Test User", userType: UserType.student);

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "test";
    final String requestUrl = '$apiUrl/users/$username';

    // Define the mocked response.
    when(mockClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response(user.toJsonString(), 200));

    // Test the initial state.
    await tester.pumpWidget(MainTestAppLoginPage(
      preferences: testPreferences,
      client: mockClient,
    ));

    expect(find.byType(LoginPage), findsOneWidget);

    // Enter the username.
    await tester.enterText(find.byType(TextField), username);

    // Tap the login button.
    await tester.tap(find.byKey(const Key('loginButton')));

    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
  });

  testWidgets('Test: Login with invalid username', (tester) async {
    // Mock the SharedPreferences.
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Mock the http.Client.
    var mockClient = MockClient();

    // Mock the response from the server.
    AppUser user = AppUser(
        userName: "unknown",
        fullName: "Unknown User",
        userType: UserType.student);

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "unknown";
    final String requestUrl = '$apiUrl/users/$username';

    // Define the mocked response.
    when(mockClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response(user.toJsonString(), 404));

    // Test the initial state.
    await tester.pumpWidget(MainTestAppLoginPage(
      preferences: testPreferences,
      client: mockClient,
    ));

    expect(find.byType(LoginPage), findsOneWidget);

    // Enter the username.
    await tester.enterText(find.byType(TextField), username);

    // Tap the login button.
    await tester.tap(find.byKey(const Key('loginButton')));

    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('Test: Login with guest user (successful)', (tester) async {
    // Mock the SharedPreferences.
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Mock the http.Client.
    var mockClient = MockClient();

    // Mock the response from the server.
    AppUser user = AppUser(
        userName: "guest", fullName: "Special guest", userType: UserType.guest);

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "guest";
    final String requestUrl = '$apiUrl/users/$username';

    // Define the mocked response.
    when(mockClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response(user.toJsonString(), 200));

    // Test the initial state.
    await tester.pumpWidget(MainTestAppLoginPage(
      preferences: testPreferences,
      client: mockClient,
    ));

    expect(find.byType(LoginPage), findsOneWidget);

    // Enter the username.
    await tester.enterText(find.byType(TextField), username);

    // Tap the login button.
    await tester.tap(find.byKey(const Key('guestLoginButton')));

    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
  });

  testWidgets('Test: Login with guest user (failed)', (tester) async {
    // Mock the SharedPreferences.
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Mock the http.Client.
    var mockClient = MockClient();

    // Mock the response from the server.
    AppUser user = AppUser(
        userName: "guest", fullName: "Special guest", userType: UserType.guest);

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "guest";
    final String requestUrl = '$apiUrl/users/$username';

    // Define the mocked response.
    when(mockClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response(user.toJsonString(), 404));

    // Test the initial state.
    await tester.pumpWidget(MainTestAppLoginPage(
      preferences: testPreferences,
      client: mockClient,
    ));

    expect(find.byType(LoginPage), findsOneWidget);

    // Enter the username.
    await tester.enterText(find.byType(TextField), username);

    // Tap the login button.
    await tester.tap(find.byKey(const Key('guestLoginButton')));

    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
