import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/model/task.dart';
import 'package:organisation_app/settings/environment.dart';

class Backend {
  static final Backend _singleton = Backend._internal();

  factory Backend() {
    return _singleton;
  }

  Backend._internal() {
    // init things inside this
  }

  // Access the backend API
  static final _backend = "${Environment.apiUrl}/";

  // get item list from backend
  Future<List<Task>> fetchItemList(http.Client client) async {
    // access REST interface with get request
    final response = await client.get(Uri.parse('${_backend}tasks'));

    // check response from backend
    if (response.statusCode == 200) {
      return List<Task>.from(json
          .decode(utf8.decode(response.bodyBytes))
          .map((x) => Task.fromJson(x)));
    } else {
      throw Exception('Failed to load Itemlist');
    }
  }

  // save new item on backend
  Future<Task> createTask(http.Client client, String name, String deadline,
      int priority, bool done, String frequency) async {
    Map data = {
      'task_name': name,
      'priority': priority,
      'is_done': done,
      'frequency': frequency,
      'deadline': deadline,
    };

    // access REST interface with post request
    var response = await client.post(Uri.parse('${_backend}tasks/task'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

    // check response from backend
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to create item');
    }
  }

  // Update item on backend
  Future<void> updateTask(http.Client client, int id, String name,
      String deadline, int priority) async {
    Map data = {
      'id': id,
      'name': name,
      'deadline': deadline,
      'priority': priority,
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
  Future<void> deleteTask(http.Client client, int id) async {
    Map data = {
      'id': id,
    };

    // access REST interface with delete request
    var response = await client.delete(
        Uri.parse('${_backend}tasks/task/{{id}}'),
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

  // set done value of item on backend
  Future<void> updateItemDoneStatus(
      http.Client client, int id, bool? done) async {
    Map data = {
      'id': id,
      'done': done,
    };

    // access REST interface with put request
    var response = await client.put(Uri.parse('${_backend}item/done'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

    // check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  // create a Get request for the backend
  Future<List<String>> getRequest(http.Client client, String url) async {
    // access REST interface with get request
    final response = await client.get(Uri.parse('$_backend$url'));

    // check response from backend
    if (response.statusCode == 200) {
      return List<String>.from(
          json.decode(utf8.decode(response.bodyBytes)).map((x) => x));
    } else {
      throw Exception('Failed to load $url');
    }
  }
}
