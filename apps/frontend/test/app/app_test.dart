import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/app.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Test: Main widgets are loading', (tester) async {
    await tester.pumpWidget(const OrganisationApp());
    expect(find.byType(MultiProvider), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
