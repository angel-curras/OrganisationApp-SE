import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/model/task.dart';

void main() {
  group('Task Tests', () {
    test('Task can be created', () {
      final task = Task(
        id: 1,
        name: 'Sample Task',
        priority: 2,
        deadline: DateTime.now(),
        done: false,
        frequency: 'daily',
      );

      expect(task, isNotNull);
      expect(task.id, 1);
      expect(task.name, 'Sample Task');
      expect(task.priority, 2);
      expect(task.deadline, isA<DateTime>());
      expect(task.done, false);
      expect(task.frequency, 'daily');
    });

    test('Task.fromJson creates a Task object from JSON', () {
      final json = {
        "id": 1,
        "name": "Sample Task",
        "priority": 2,
        "deadline": DateTime.now().toIso8601String(),
        "done": false,
        "frequency": "daily",
      };

      final task = Task.fromJson(json);

      expect(task, isNotNull);
      expect(task.id, 1);
      expect(task.name, 'Sample Task');
      expect(task.priority, 2);
      expect(task.deadline, isA<DateTime>());
      expect(task.done, false);
      expect(task.frequency, 'daily');
    });

    test('toJson returns a JSON representation of Task', () {
      final task = Task(
        id: 1,
        name: 'Sample Task',
        priority: 2,
        deadline: DateTime.now(),
        done: false,
        frequency: 'daily',
      );

      final json = task.toJson();

      expect(json, isNotNull);
      expect(json['id'], 1);
      expect(json['name'], 'Sample Task');
      expect(json['priority'], 2);
      expect(json['deadline'], isA<String>());
      expect(json['done'], false);
      expect(json['frequency'], 'daily');
    });

    test('deadlineDate returns the correct deadline date', () {
      final deadline = DateTime(2023, 1, 1);
      final task = Task(
        id: 1,
        name: 'Sample Task',
        priority: 2,
        deadline: deadline,
        done: false,
        frequency: 'daily',
      );

      expect(task.deadlineDate, equals(deadline));
    });
  });
}
