import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/settings/environment.dart';

String BASE_URL = "http://";

class Backend {
  static final Backend _singleton = Backend._internal();

  factory Backend() {
    return _singleton;
  }

  Backend._internal() {
    // init things inside this
  }

  // use IP 10.0.2.2 to access localhost from windows client
  static final _backend = "${Environment.apiUrl}/";

  // Update item on backend
  Future<void> updateItem(
      http.Client client, int id, String name, String description) async {
    Map data = {
      'id': id,
      'name': name,
      'description': description,
    };

    // access REST interface with put request
    var response = await client.put(Uri.parse('${_backend}item'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

// check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  // delete item on backend
  Future<void> deleteItem(http.Client client, int id) async {
    Map data = {
      'id': id,
    };

    // access REST interface with delete request
    var response = await client.delete(Uri.parse('${_backend}item'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

    // check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }

  // Get modules
  Future<List<Module>> fetchModuleList(http.Client client) async {
    // Access REST interface with get request
    final response = await client.get(Uri.parse('${_backend}modules'));

    // Check response from backend
    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      // Extract the list from the 'content' field
      var content = jsonData['content'];
      if (content != null) {
        var modules = List<Module>.from(content.map((x) => Module.fromJson(x)));
        return modules;
      } else {
        throw Exception('Content field is missing in the JSON data');
      }
    } else {
      throw Exception('Failed to load Module list');
    }
  }

  // Get modules with pagination and sorting
  Future<List<Module>> fetchModuleListWithPaginationAndSorting(
    http.Client client, {
    int page = 0,
    int size = 10,
    String sortBy = 'name',
    String sortDir = 'asc',
    String searchQuery = '',
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'size': size.toString(),
        'sortBy': sortBy,
        'sortDir': sortDir,
      };

      if (searchQuery.isNotEmpty) {
        queryParams['search'] =
            searchQuery; // Add the search query if not empty
      }
      // Construct the URL with query parameters for pagination and sorting
      final url =
          Uri.parse('${_backend}modules').replace(queryParameters: queryParams);

      // Make the GET request
      final response = await client.get(url);

      // Check the response status
      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        var content = jsonData['content'];
        if (content != null) {
          return List<Module>.from(content.map((x) => Module.fromJson(x)));
        } else {
          throw Exception('Content field is missing in the JSON data');
        }
      } else {
        throw Exception('Failed to load Module list');
      }
    } catch (e) {
      throw Exception('Error fetching modules with pagination and sorting: $e');
    }
  }

  // Get module
  Future<Module> fetchModule(http.Client client, int id) async {
    // access REST interface with get request
    final response = await client.get(Uri.parse('${_backend}modules/$id'));

    // check response from backend
    if (response.statusCode == 200) {
      return Module.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to fetch Module');
    }
  }
}
