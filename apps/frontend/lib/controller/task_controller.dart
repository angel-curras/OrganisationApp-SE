import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organisation_app/model/task.dart';
import 'package:organisation_app/settings/environment.dart';

class TaskController {
  static final _apiUrl = Environment.apiUrl;
  final http.Client _client;

  // Getters
  http.Client get client => _client;

  TaskController({required http.Client client}) : _client = client;

  // get item list from backend
  Future<List<Task>> fetchItemList() async {
    // access REST interface with get request
    final response = await _client.get(Uri.parse('$_apiUrl/tasks'));

    // check response from backend
    if (response.statusCode == 200) {
      return List<Task>.from(json
          .decode(utf8.decode(response.bodyBytes))
          .map((x) => Task.fromJson(x)));
    } else {
      throw Exception('Failed to load Item list');
    }
  }

  // save new item on backend
  Future<Task> createTask(String name, String deadline, int priority, bool done,
      String frequency) async {
    Map data = {
      'task_name': name,
      'priority': priority,
      'deadline': deadline,
      'is_done': done,
      'frequency': frequency,
    };

    // access REST interface with post request
    var response = await _client.post(Uri.parse('$_apiUrl/tasks'),
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
  Future<void> updateTask(int id, String name, String deadline, int priority,
      bool done, String frequency) async {
    Map data = {
      'task_id': id,
      'task_name': name,
      'priority': priority,
      'deadline': deadline,
      'is_done': done,
      'frequency': frequency,
    };

    // access REST interface with put request
    var response = await _client.put(Uri.parse('$_apiUrl/tasks/$id'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

// check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  // delete item on backend
  Future<void> deleteTask(int id) async {
    // access REST interface with delete request
    var response = await _client.delete(
      Uri.parse('$_apiUrl/tasks/$id'),
      headers: <String, String>{'Content-Type': 'application/json'},
    );

    // check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }

  // set done value of item on backend
  Future<void> updateItemDoneStatus(int id, bool? done) async {
    Map data = {
      'id': id,
      'done': done,
    };

    // access REST interface with put request
    var response = await _client.put(Uri.parse('$_apiUrl/item/done'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

    // check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }
} // end of class TaskController
