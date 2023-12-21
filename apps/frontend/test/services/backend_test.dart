import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:organisation_app/model/item.dart';
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/services/backend.dart';

class MockClient extends Mock implements http.Client {
  bool contentSetToNull = false;
  bool return200 = true;
  // Add mock implementations if needed
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    // Check if the URL ends with a numeric ID, indicating a request for a single module
    RegExp singleModulePattern = RegExp(r'modules/\d+$');
    if (singleModulePattern.hasMatch(url.toString())) {
      // Mock response for getModule
      return _mockGetModuleResponse();
    } else {
      // Mock response for getModules
      return _mockGetModulesResponse();
    }
  }

  Future<http.Response> _mockGetModuleResponse() {
    if (!return200) {
      return Future.value(http.Response(
          json.encode({'headers': 'internal server error'}), 500));
    }

    return Future.value(http.Response(
        json.encode({
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
        }),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        200));
  }

  Future<http.Response> _mockGetModulesResponse() {
    if (contentSetToNull) {
      return Future.value(http.Response(json.encode({'headers': 'hi'}), 200));
    }
    if (!return200) {
      return Future.value(http.Response(
          json.encode({'headers': 'internal server error'}), 500));
    }
    return Future.value(http.Response(
        json.encode({
          'content': [
            {
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
            },
            {
              'id': 2,
              'zpaId': 456,
              'name': 'Test Module 2',
              'anzahlSprachen': 1,
              'verantwortlich': 'Jane Doe',
              'sws': 2,
              'ects': 3,
              'sprachen': 'English',
              'lehrform': 'Lecture',
              'angebot': 'WS 2023/24',
              'aufwand': 'Medium',
              'voraussetzungen': 'Basic Knowledge',
              'ziele': 'Understand Y',
              'inhalt': 'Covers topics in Y',
              'medienUndMethoden': 'Slides, Videos',
              'literatur': 'Book A, Book B',
              'url': 'http://example.com',
            },
          ]
        }),
        200));
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // return mock response
    return Future.value(http.Response(
        json.encode({
          'id': 1,
          'name': 'Test',
          'description': 'Test',
        }),
        200));
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // return mock response
    return Future.value(http.Response(
        json.encode({
          'id': 1,
          'name': 'Test',
          'description': 'Test',
        }),
        200));
  }
}

void main() {
  group('Backend Tests', () {
    MockClient mockClient;
    Backend backend;

    test(
        'fetchModuleList returns a list of Modules if the http call completes successfully',
        () async {
      mockClient = MockClient();
      backend = Backend();

      expect(await backend.fetchModuleList(mockClient), isA<List<Module>>());
    });

    test('fetchModuleList throws an error if content is null', () async {
      mockClient = MockClient();
      backend = Backend();

      mockClient.contentSetToNull = true;

      expectLater(backend.fetchModuleList(mockClient),
          throwsException // or a more specific exception if applicable
          );
    });

    test('fetchModuleList doesn\'t return a 200', () async {
      mockClient = MockClient();
      backend = Backend();

      mockClient.return200 = false;

      expectLater(backend.fetchModuleList(mockClient),
          throwsException // or a more specific exception if applicable
          );
    });

    test(
        'fetchModuleListWithPaginationAndSorting returns a list of Modules if the http call completes successfully',
        () async {
      mockClient = MockClient();
      backend = Backend();

      expect(
          await backend.fetchModuleListWithPaginationAndSorting(mockClient,
              page: 1, size: 10, sortBy: 'name', sortDir: 'asc'),
          isA<List<Module>>());
    });

    test(
        'fetchModuleListWithPaginationAndSorting returns a list of Modules if the http call completes successfully',
        () async {
      mockClient = MockClient();
      backend = Backend();

      expect(
          await backend.fetchModuleListWithPaginationAndSorting(mockClient,
              page: 1,
              size: 10,
              sortBy: 'name',
              sortDir: 'asc',
              searchQuery: 'Test'),
          isA<List<Module>>());
    });

    test(
        'fetchModuleListWithPaginationAndSorting throws an error if content is null',
        () async {
      mockClient = MockClient();
      backend = Backend();

      mockClient.contentSetToNull = true;

      expectLater(
          backend.fetchModuleListWithPaginationAndSorting(mockClient,
              page: 1, size: 10, sortBy: 'name', sortDir: 'asc'),
          throwsException // or a more specific exception if applicable
          );
    });

    test('fetchModuleListWithPaginationAndSorting doesn\'t return a 200',
        () async {
      mockClient = MockClient();
      backend = Backend();

      mockClient.return200 = false;

      expectLater(
          backend.fetchModuleListWithPaginationAndSorting(mockClient,
              page: 1, size: 10, sortBy: 'name', sortDir: 'asc'),
          throwsException // or a more specific exception if applicable
          );
    });

    test('fetchModule returns a Module if the http call completes successfully',
        () async {
      mockClient = MockClient();
      backend = Backend();

      expect(await backend.fetchModule(mockClient, 1), isA<Module>());
    });

    test('fetchModule doesn\'t return a 200', () async {
      mockClient = MockClient();
      backend = Backend();

      mockClient.return200 = false;

      expectLater(backend.fetchModule(mockClient, 1),
          throwsException // or a more specific exception if applicable
          );
    });
  });
}
