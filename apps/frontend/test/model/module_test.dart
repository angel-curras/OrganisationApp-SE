import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/model/module.dart';

void main() {
  test('should create an instance of Module with correct properties', () {
    final module = Module(
      id: 1,
      zpaId: 123,
      name: 'Test Module',
      anzahlSprachen: 2,
      verantwortlich: 'John Doe',
      sws: 4,
      ects: 6,
      sprachen: 'English, German',
      lehrform: 'Lecture',
      angebot: 'WS 2023/24',
      aufwand: 'Medium',
      voraussetzungen: 'Basic Knowledge',
      ziele: 'Understand X',
      inhalt: 'Covers topics in X',
      medienUndMethoden: 'Slides, Videos',
      literatur: 'Book A, Book B',
      url: 'http://example.com',
    );

    expect(module.id, equals(1));
    expect(module.zpaId, equals(123));
    expect(module.name, equals('Test Module'));
    expect(module.anzahlSprachen, equals(2));
    expect(module.verantwortlich, equals('John Doe'));
    expect(module.sws, equals(4));
    expect(module.ects, equals(6));
    expect(module.sprachen, equals('English, German'));
    expect(module.lehrform, equals('Lecture'));
    expect(module.angebot, equals('WS 2023/24'));
    expect(module.aufwand, equals('Medium'));
    expect(module.voraussetzungen, equals('Basic Knowledge'));
    expect(module.ziele, equals('Understand X'));
    expect(module.inhalt, equals('Covers topics in X'));
    expect(module.medienUndMethoden, equals('Slides, Videos'));
    expect(module.literatur, equals('Book A, Book B'));
    expect(module.url, equals('http://example.com'));
  });

  // Test for toJson
  test('toJson should return a valid map', () {
    final module = Module(
      id: 1,
      zpaId: 123,
      name: 'Test Module',
      anzahlSprachen: 2,
      verantwortlich: 'John Doe',
      sws: 4,
      ects: 6,
      sprachen: 'English, German',
      lehrform: 'Lecture',
      angebot: 'WS 2023/24',
      aufwand: 'Medium',
      voraussetzungen: 'Basic Knowledge',
      ziele: 'Understand X',
      inhalt: 'Covers topics in X',
      medienUndMethoden: 'Slides, Videos',
      literatur: 'Book A, Book B',
      url: 'http://example.com',
    );

    final json = module.toJson();

    expect(json, isA<Map<String, dynamic>>());
    expect(json['id'], equals(1));
    expect(json['zpaId'], equals(123));
    expect(module.name, equals('Test Module'));
    expect(module.anzahlSprachen, equals(2));
    expect(module.verantwortlich, equals('John Doe'));
    expect(module.sws, equals(4));
    expect(module.ects, equals(6));
    expect(module.sprachen, equals('English, German'));
    expect(module.lehrform, equals('Lecture'));
    expect(module.angebot, equals('WS 2023/24'));
    expect(module.aufwand, equals('Medium'));
    expect(module.voraussetzungen, equals('Basic Knowledge'));
    expect(module.ziele, equals('Understand X'));
    expect(module.inhalt, equals('Covers topics in X'));
    expect(module.medienUndMethoden, equals('Slides, Videos'));
    expect(module.literatur, equals('Book A, Book B'));
    expect(module.url, equals('http://example.com'));
  });

  // Test for fromJson
  test('fromJson should return a valid Module instance', () {
    final json = {
      'id': 1,
      'zpaId': 123,
      'name': 'Test Module',
      'anzahlSprachen': 2,
      'verantwortlich': 'John Doe',
      'sws': 4,
      'ects': 6,
      'sprachen': 'English, German',
      'lehrform': 'Lecture',
      'angebot': 'WS 2023/24',
      'aufwand': 'Medium',
      'voraussetzungen': 'Basic Knowledge',
      'ziele': 'Understand X',
      'inhalt': 'Covers topics in X',
      'medienUndMethoden': 'Slides, Videos',
      'literatur': 'Book A, Book B',
      'url': 'http://example.com',
    };

    final module = Module.fromJson(json);

    expect(module, isA<Module>());
    expect(module.id, equals(1));
    expect(module.zpaId, equals(123));
    expect(module.name, equals('Test Module'));
    expect(module.anzahlSprachen, equals(2));
    expect(module.verantwortlich, equals('John Doe'));
    expect(module.sws, equals(4));
    expect(module.ects, equals(6));
    expect(module.sprachen, equals('English, German'));
    expect(module.lehrform, equals('Lecture'));
    expect(module.angebot, equals('WS 2023/24'));
    expect(module.aufwand, equals('Medium'));
    expect(module.voraussetzungen, equals('Basic Knowledge'));
    expect(module.ziele, equals('Understand X'));
    expect(module.inhalt, equals('Covers topics in X'));
    expect(module.medienUndMethoden, equals('Slides, Videos'));
    expect(module.literatur, equals('Book A, Book B'));
    expect(module.url, equals('http://example.com'));
  });
}
