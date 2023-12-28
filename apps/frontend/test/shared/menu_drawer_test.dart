import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/shared/menu_drawer.dart';
import 'package:provider/provider.dart';

class MainTestApp extends StatelessWidget {
  const MainTestApp({super.key});

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
          routes: appRoutes,
          home: const Scaffold(
            body: MenuDrawer(),
          ),
        ));
  }
}

void main() {
  setUp(() async {
    await setUpApp();
  }); // end of setUp()

  testWidgets('Test: Widgets initialized', (tester) async {
    await tester.pumpWidget(const MainTestApp());
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
