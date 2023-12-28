import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/home/home_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';

import 'home_page_test.mocks.dart';

class MainTestAppHomePage extends StatelessWidget {
  final http.Client httpClient;

  const MainTestAppHomePage({super.key, required this.httpClient});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppSettings()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: Scaffold(
            body: MyCoursesPage(
              client: httpClient,
            ),
          ),
        ));
  }
}

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpApp();
  }); // end of setUp()

  testWidgets('Test: Laden von zwei Items', (tester) async {
    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "test";
    final String requestUrl = '$apiUrl/courses/user/$username';

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Define the mocked response.
    when(mockHttpClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response('[]', 200));

    await tester.pumpWidget(MainTestAppHomePage(
      httpClient: mockHttpClient,
    ));
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 200));
  });
}
