import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/primuss/primuss_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../shared/mock_web_view_plattform.dart';

class MainTestAppWebPage extends StatelessWidget {
  final SharedPreferences _preferences;
  final WebViewController _webViewController;

  const MainTestAppWebPage(
      {super.key,
      required SharedPreferences preferences,
      required WebViewController webViewController})
      : _preferences = preferences,
        _webViewController = webViewController;

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
            body: PrimussPage(
              webViewController: _webViewController,
            ),
          ),
        ));
  }
}

void main() {
  setUp(() async {
    await setUpEnvironment();
    WebViewPlatform.instance = MockWebViewPlatform();
  }); // end of setUp()

  testWidgets('Test: Primuss page started', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(MainTestAppWebPage(
      preferences: testPreferences,
      webViewController: WebViewController(),
    ));
  });
}
