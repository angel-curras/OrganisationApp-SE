import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Test: Main widgets are loading', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(OrganisationApp(
      preferences: prefs,
    ));
    expect(find.byType(MultiProvider), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
