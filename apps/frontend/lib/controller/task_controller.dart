import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:organisation_app/model/task.dart';
import 'package:organisation_app/settings/environment.dart';

class TaskController {
  static final Logger _logger = Logger();
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
          .map((x) => Task.fromJsonMap(x)));
    } else {
      throw Exception('Failed to load Item list');
    }
  }

  // save new item on backend
  Future<Task> createTask(
      String userName, String taskName, DateTime deadline, int priority) async {
    Task task = Task(
      name: taskName,
      priority: priority,
      deadline: deadline,
    );

    _logger.i("Creating a new task for user '$userName'. Task: '$task'");

    // access REST interface with post request
    var response = await _client.post(Uri.parse('$_apiUrl/tasks/$userName'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: task.toJsonString());

    // check response from backend
    if (response.statusCode == 200) {
      return Task.fromJsonMap(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to create item');
    }
  }

  // Update item on backend
  Future<void> updateTask(Task task) async {
    // access REST interface with put request
    var response = await _client.put(Uri.parse('$_apiUrl/tasks/${task.id}'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: task.toJsonString());

// check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  // delete item on backend
  Future<void> deleteTask(int id) async {
    // access REST interface with delete request
    var response = await _client.delete(Uri.parse('$_apiUrl/tasks/$id'));

    // check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }

  // set done value of item on backend
  Future<void> updateItemDoneStatus(int id, bool? done) async {
    Task task = Task(
      id: id,
      done: done ?? false,
    );

    // access REST interface with put request
    var response = await _client.put(Uri.parse('$_apiUrl/item/done'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: task.toJsonString());

    // check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  Future<List<Task>> getAllTasksForUser(String username) async {
    // access REST interface with get request
    final response = await _client.get(Uri.parse('$_apiUrl/tasks/$username'));

    // check response from backend
    if (response.statusCode == 200) {
      return List<Task>.from(json
          .decode(utf8.decode(response.bodyBytes))
          .map((x) => Task.fromJsonMap(x)));
    } else {
      throw Exception('Failed to load Item list');
    }
  }
} // end of class TaskController
