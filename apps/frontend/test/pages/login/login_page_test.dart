import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';

class MainTestAppLoginPage extends StatelessWidget {
  const MainTestAppLoginPage({super.key});

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
            home: LoginPage()));
  }
}

void main() {
  setUp(() async {
    await setUpApp();
  }); // end of setUp()

  testWidgets('Test: Initialize widgets', (tester) async {
    // Create a mock HTTP client.

    await tester.pumpWidget(const MainTestAppLoginPage());
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Center), findsNWidgets(3));
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(9));
    expect(find.byType(Image), findsNWidgets(2));
  });
}
