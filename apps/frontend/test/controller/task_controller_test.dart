import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/controller/task_controller.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/task.dart';
import 'package:organisation_app/settings/environment.dart';

import '../app/routes_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  setUpAll(() async {
    await setUpEnvironment();
  });

  group('TaskController Tests', () {
    late MockClient mockClient;
    late TaskController taskController;
    const String username = 'test';
    late String apiUrl;

    setUp(() {
      // Initialize the mock http client and task controller in the setUp method
      mockClient = MockClient();
      taskController = TaskController(client: mockClient);
      apiUrl = Environment.apiUrl;
    });

    // Test injection of http client
    test('getClient returns injected http client', () {
      // Act
      final httpClient = taskController.client;

      // Assert
      expect(httpClient, isA<http.Client>());
      expect(httpClient,
          same(mockClient)); // Make sure it's the exact same instance
    });

    // Test case to cover a non-200 HTTP response
    test('getAllTasksForUser returns a list of tasks on successful HTTP call',
        () async {
      // Arrange
      final url = Uri.parse('$apiUrl/tasks/$username');
      final mockTasks = [
        Task(id: 1, name: 'Task 1', priority: 1, deadline: DateTime.now()),
        Task(
            id: 2,
            name: 'Task 2',
            priority: 2,
            deadline: DateTime.now().add(const Duration(days: 1))),
      ];

      final mockResponseJson =
          json.encode(mockTasks.map((task) => task.toJsonMap()).toList());

      when(mockClient.get(url))
          .thenAnswer((_) async => http.Response(mockResponseJson, 200));

      // Act
      final result = await taskController.getAllTasksForUser(username);

      // Assert
      expect(result, isA<List<Task>>());
      expect(result.length, mockTasks.length);
      for (int i = 0; i < result.length; i++) {
        expect(result[i].id, mockTasks[i].id);
        expect(result[i].name, mockTasks[i].name);
        // Compare other fields as necessary
      }
    });

    // test case to cover a exeption
    test('getAllTasksForUser throws an exception for non-200 response', () {
      // Arrange
      final url = Uri.parse('$apiUrl/tasks/$username');
      when(mockClient.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(
          () => taskController.getAllTasksForUser(username), throwsException);
    });

    // Test case to cover a 200 HTTP response
    test('createTask returns right value', () async {
      // Arrange
      final url = Uri.parse('$apiUrl/tasks/$username');
      final Task newTask = Task(
        name: 'Important Task',
        priority: 1,
        deadline: DateTime.now(),
      );

      // your task to a JSON string for the body of the request
      final responseJson = newTask.toJsonString();

      when(mockClient.post(
        url,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(responseJson, 200));

      DateTime deadline = newTask.deadline ?? DateTime.now();
      // Act
      Task result = await taskController.createTask(
        username,
        newTask.name,
        deadline,
        newTask.priority,
      );

      // Assert
      expect(result, isA<Task>());
      expect(result.name,
          equals(newTask.name)); // Assuming your Task object has a 'name' field
      // Add more assertions as needed to check other properties
    });

    // Test case to cover a non-200 HTTP response
    test('createTask throws an exception for non-200 response', () {
      // Arrange
      final url = Uri.parse('$apiUrl/tasks/$username');
      final Task newTask = Task(
        name: 'Important Task',
        priority: 1,
        deadline: DateTime.now(),
      );
      when(mockClient.post(
        url,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Conflict', 409));

      DateTime deadline = newTask.deadline ?? DateTime.now();

      // Act & Assert
      expect(
          () => taskController.createTask(
                username,
                newTask.name,
                deadline,
                newTask.priority,
              ),
          throwsException);
    });

    // Test case to cover a non-200 HTTP response
    test('updateTask throws an exception for non-200 response', () {
      // Arrange
      final Task taskToUpdate = Task(
        id: 1,
        name: 'Updated Task',
        priority: 1,
        deadline: DateTime.now(),
      );
      final url = Uri.parse('$apiUrl/tasks/${taskToUpdate.id}');
      when(mockClient.put(
        url,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => taskController.updateTask(taskToUpdate), throwsException);
    });

    // Test case to cover a non-200 HTTP response
    test('deleteTask throws an exception for non-200 response', () {
      // Arrange
      final int taskIdToDelete = 1;
      final url = Uri.parse('$apiUrl/tasks/$taskIdToDelete');
      when(mockClient.delete(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => taskController.deleteTask(taskIdToDelete), throwsException);
    });

    // Test case to cover a non-200 HTTP response
    test('updateItemDoneStatus throws an exception for non-200 response', () {
      // Arrange
      final int taskIdToUpdate = 1;
      final url = Uri.parse('$apiUrl/item/done');
      when(mockClient.put(
        url,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => taskController.updateItemDoneStatus(taskIdToUpdate, true),
          throwsException);
    });
  });
}
