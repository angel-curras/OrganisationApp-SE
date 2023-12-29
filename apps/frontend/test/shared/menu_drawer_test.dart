import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/shared/menu_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainTestApp extends StatelessWidget {
  final SharedPreferences _preferences;

  const MainTestApp({super.key, required SharedPreferences preferences})
      : _preferences = preferences;

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
          routes: appRoutes,
          home: const Scaffold(
            body: MenuDrawer(),
          ),
        ));
  }
}

void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Test: Widgets initialized', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(MainTestApp(
      preferences: testPreferences,
    ));
    expect(find.byType(MenuDrawer), findsOneWidget);
    expect(find.byType(Drawer), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(7));
    expect(find.byType(Icon), findsNWidgets(8));
    expect(find.byType(Text), findsNWidgets(9));
    expect(find.byType(Divider), findsNWidgets(2));
  });
}
