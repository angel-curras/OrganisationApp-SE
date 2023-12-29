import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../shared/mock_web_view_plattform.dart';

void main() {
  setUp(() {
    WebViewPlatform.instance = MockWebViewPlatform();
  }); // end of setUp()
  group('Routes tests', () {
    // Define the test parameters
    final testCases = [
      {'route_name': "/init", 'widget_class': "InitializationPage"},
      {'route_name': "/login", 'widget_class': "LoginPage"},
      {'route_name': '/init', 'widget_class': "InitializationPage"},
      {'route_name': '/my_courses', 'widget_class': "MyCoursesPage"},
      {'route_name': '/login', 'widget_class': "LoginPage"},
      {'route_name': '/modules', 'widget_class': "CoursesPage"},
      {'route_name': '/todos', 'widget_class': "TodosPage"},
      {'route_name': '/moodle', 'widget_class': "MoodlePage"},
      {'route_name': '/chatgpt', 'widget_class': "ChatGptPage"},
      {'route_name': '/primuss', 'widget_class': "PrimussPage"},
    ];

    // Iterate over test parameters and create individual tests
    for (final testCase in testCases) {
      test('Testing route: ${testCases.indexOf(testCase) + 1}', () {
        // Extract input and expected values
        final routeName = testCase['route_name'] as String;
        final String? expectedWidgetType = testCase['widget_class'];

        var route = appRoutes[routeName];
        expect(route, isNotNull);
        expect(route, isA<Widget Function(BuildContext)>());

        var widget = route!(null);
        expect(widget, isNotNull);
        expect(widget.runtimeType.toString(), expectedWidgetType);
      });
    }
  });

  tearDown(() {
    // This function is called after each test.
  }); // end of tearDown()
}
