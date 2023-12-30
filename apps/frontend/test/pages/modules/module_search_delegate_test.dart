import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:organisation_app/controller/module_controller.dart';
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/pages/modules/module_search_delegate.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockClient extends Mock implements http.Client {}

class MockModuleController extends Mock implements ModuleController {
  bool shouldThrowError = false;

  @override
  Future<List<Module>> fetchModuleListWithPaginationAndSorting(
    http.Client client, {
    int page = 0,
    int size = 10,
    String sortBy = 'name',
    String sortDir = 'asc',
    String searchQuery = '',
  }) async {
    if (shouldThrowError) {
      throw Exception('Error: Mocked error');
    }
    // Return your mock data here
    return [
      Module(
        id: 446,
        zpaId: 446,
        name: 'IT-Consulting',
        verantwortlich: 'Prof. Dr. Markus Thimmel',
        sws: 4,
        ects: 5,
        sprachen: 'Deutsch, Englisch',
        anzahlSprachen: 2,
        lehrform: 'SU mit Praktikum',
        angebot: 'in jedem Sommersemester',
        aufwand: 'Präsenzstudium: ca. 42 Std., Eigenstudium: ca. 108 Std.',
        voraussetzungen: 'keine',
        ziele:
            'Die Studierenden lernen ausgewählte Methoden und Konzepte des IT Consulting kennen und können diese eigenständig anwenden.\n Kenntnisse und fachliche sowie überfachliche Kompetenzen:\n\n Die Studierenden lernen Unternehmensberatung kennen und können IT Consulting in die existierende Beratungslandschaft einordnen\n Die Studierenden lernen die strategische Relevanz von IT Consulting kennen\n Die Studierenden erhalten Einblicke in den Bedarf von (interner) Unternehmensberatung mit Fokus auf IT Consulting\n Die Studierenden erhalten Einblicke in den Aufbau, die Struktur und den Ablauf gewöhnlicher IT-Projekte\n Die Studierenden erlangen die Kompetenz, komplexe Projektanforderungen zu strukturieren\n Die Studierenden erlernen ausgewählte Methoden und Ansätze des Controllings von IT-Projekten\n Die Studierenden erhalten Einblicke in die Koordination und Steuerung von IT-Projekten und größeren Projektteams\n Die Studierenden entwickeln ihre Präsentations- und Teamfähigkeiten weiter',
        inhalt:
            'Einführung in die Unternehmensberatung\n Einführung in das IT Consulting als wesentlicher Bereich der Unternehmensberatung\n Methoden des Anforderungsmanagement\n Methoden des IT-Projektmanagement und IT-Projektcontrolling\n Best Practice Ansätze im Bereich des IT-Projektmanagement\n IT Consulting als Geschäftsmodell\n Inhouse-Consulting als besondere Form der beratenden Tätigkeit',
        medienUndMethoden:
            'Moodle\n Vorlesungsskript\n Übungsskript\n Coaching durch den Dozenten\n Tafel\n\n Im Rahmen dieses Moduls kann auch eine Exkursion durchgeführt werden.',
        literatur:
            'D. Lippold: Einführung in das Consulting: Strukturen – Trends – Geschäftsmodelle, 2022\n G. Blokdyk: IT Consulting Services - Second Edition, 2021\n T. McMakin: How Clients Buy, 2018\n C. Schulz: Consulting-Methodenkoffer, 2022',
        url: 'https://zpa.cs.hm.edu/public/module/446/',
      ),
      Module(
        id: 442,
        zpaId: 442,
        name: 'Digitale Forensik',
        verantwortlich: 'Prof. Dr.-Ing. Thomas Schreck',
        sws: 4,
        ects: 5,
        sprachen: 'Deutsch',
        anzahlSprachen: 1,
        lehrform: 'SU mit Praktikum',
        angebot: 'in jedem Sommersemester',
        aufwand:
            '30 Präsenzstunden Vorlesung, 30 Präsenzstunden Praktikum, 45 Stunden Vor-/Nachbereitung des Praktikums, 45 Stunden Nachbereitung der Vorlesung und Prüfungsvorbereitung',
        voraussetzungen: 'Grundlagenkenntnisse der IT-Sicherheit',
        ziele:
            'Folgende Kompetenzen werden vermittelt:\n\n Studierende kennen die Grundlagen der digitalen Forensik und können diese anwenden\n Studierende kennen die grundlegenden Schritte eines IT-Forensikers und können mit allgemeinen und speziellen forensischen Werkzeugen sicher umgehen\n Studierende können selbstständig komplexe forensische Analysen durchführen\n Studierende erlangen die Fähigkeit eine forensische Untersuchung durchzuführen und sind in der Lage die Ergebnisse zu bewerten\n Studierende sind befähigt eigene forensischen Anwendungen zu entwickeln',
        inhalt:
            'Es werden die verschiedenen Bereiche des Gebietes "Digitale Forensik" thematisiert und mit praktischen Übungen ergänzt:\n\n Grundlagen der digitalen Forensik\n Digitale Spuren\n Datenträgeranalyse\n Festplattenforensik\n Arbeitsspeicherforensik\n Analyse mit forensischen Tools\n Vorgehensmodelle, Berichterstellung',
        medienUndMethoden:
            'Tafel, Folien, Beamer, Gastvorträge\n\n Es wird ein Praktikum angeboten, in dem die Studierenden die erlernten Methoden und Werkzeuge anwenden können.',
        literatur:
            'Forensische Informatik; Andreas Dewald und Felix Freiling; ISBN-13: 978-3842379473',
        url: 'https://zpa.cs.hm.edu/public/module/442/',
      ),
    ];
  }
}

void main() {
  setUp(() async {
    // Load the .env file
    await dotenv.load(fileName: Environment.fileName);
  });

  group('ModuleSearchDelegate Tests', () {
    late MockClient mockClient;
    late MockModuleController mockBackend;

    // Test overall functionality of ModuleSearchDelegate
    setUp(() {
      mockClient = MockClient();
      mockBackend = MockModuleController();
    });

    testWidgets('Test ModuleSearchDelegate creation',
        (WidgetTester tester) async {
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: ElevatedButton(
              onPressed: () {
                showSearch(
                    context: scaffoldKey.currentContext!,
                    delegate: ModuleSearchDelegate(mockClient, mockBackend));
              },
              child: const Text('Open Search'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
    });

    testWidgets('Test Tapping close button', (WidgetTester tester) async {
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: ElevatedButton(
              onPressed: () {
                showSearch(
                    context: scaffoldKey.currentContext!,
                    delegate: ModuleSearchDelegate(mockClient, mockBackend));
              },
              child: const Text('Open Search'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
    });

    testWidgets('Test Tapping close button', (WidgetTester tester) async {
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: ElevatedButton(
              onPressed: () {
                showSearch(
                    context: scaffoldKey.currentContext!,
                    delegate: ModuleSearchDelegate(mockClient, mockBackend));
              },
              child: const Text('Open Search'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();
    });

    testWidgets('Test Snapshot data', (WidgetTester tester) async {
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: ElevatedButton(
              onPressed: () {
                showSearch(
                    context: scaffoldKey.currentContext!,
                    delegate: ModuleSearchDelegate(mockClient, mockBackend));
              },
              child: const Text('Open Search'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Prof. Dr. Markus Thimmel'), findsOneWidget);
    });

    testWidgets('Test tapping ListTile', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences testPreferences = await SharedPreferences.getInstance();
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => AppSettings(testPreferences)),
          ],
          child: MaterialApp(
            home: Scaffold(
              key: scaffoldKey,
              body: ElevatedButton(
                onPressed: () {
                  showSearch(
                      context: scaffoldKey.currentContext!,
                      delegate: ModuleSearchDelegate(mockClient, mockBackend));
                },
                child: const Text('Open Search'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // find both ListTiles
      expect(find.byType(ListTile), findsNWidgets(2));

      // tap one ListTile
      await tester.tap(find.byType(ListTile).first);

      await tester.pumpAndSettle();
    });

    testWidgets('Test tapping ListTile and going back',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences testPreferences = await SharedPreferences.getInstance();
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => AppSettings(testPreferences)),
          ],
          child: MaterialApp(
            home: Scaffold(
              key: scaffoldKey,
              body: ElevatedButton(
                onPressed: () {
                  showSearch(
                      context: scaffoldKey.currentContext!,
                      delegate: ModuleSearchDelegate(mockClient, mockBackend));
                },
                child: const Text('Open Search'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(2));

      await tester.tap(find.byType(ListTile).first);

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));

      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('Test backend error', (WidgetTester tester) async {
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
      mockBackend.shouldThrowError = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: ElevatedButton(
              onPressed: () {
                showSearch(
                    context: scaffoldKey.currentContext!,
                    delegate: ModuleSearchDelegate(mockClient, mockBackend));
              },
              child: const Text('Open Search'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
    });

    testWidgets('Test Tapping close button and entering text in search',
        (WidgetTester tester) async {
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: ElevatedButton(
              onPressed: () {
                showSearch(
                  context: scaffoldKey.currentContext!,
                  delegate: ModuleSearchDelegate(mockClient, mockBackend),
                );
              },
              child: const Text('Open Search'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'IT-Consulting');
      await tester.pumpAndSettle();

      expect(find.text('Prof. Dr. Markus Thimmel'), findsOneWidget);
    });
  });
}
