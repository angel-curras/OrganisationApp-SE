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
        frequency: Frequency.daily,
      );

      expect(task, isNotNull);
      expect(task.id, 1);
      expect(task.name, 'Sample Task');
      expect(task.priority, 2);
      expect(task.deadline, isA<DateTime>());
      expect(task.done, false);
      expect(task.frequency, Frequency.daily);
    });

    test('Task.fromJson creates a Task object from JSON', () {
      final json = {
        "task_id": 1,
        "task_name": "Sample Task",
        "priority": 2,
        "deadline": DateTime.now().toIso8601String(),
        "is_done": false,
        "frequency": Frequency.once.toJSON(),
      };

      final task = Task.fromJsonMap(json);

      expect(task, isNotNull);
      expect(task.id, 1);
      expect(task.name, 'Sample Task');
      expect(task.priority, 2);
      expect(task.deadline, isA<DateTime>());
      expect(task.done, false);
      expect(task.frequency, Frequency.once);
    });

    test('toJson returns a JSON representation of Task', () {
      final task = Task(
        id: 1,
        name: 'Sample Task',
        priority: 2,
        deadline: DateTime.now(),
        done: false,
        frequency: Frequency.weekly,
      );

      final json = task.toJsonMap();

      expect(json, isNotNull);
      expect(json['task_id'], 1);
      expect(json['task_name'], 'Sample Task');
      expect(json['priority'], 2);
      expect(json['deadline'], isA<String>());
      expect(json['is_done'], false);
      expect(json['frequency'], Frequency.weekly.toJSON());
    });

    test('deadlineDate returns the correct deadline date', () {
      final deadline = DateTime(2023, 1, 1);
      final task = Task(
        id: 1,
        name: 'Sample Task',
        priority: 2,
        deadline: deadline,
        done: false,
        frequency: Frequency.monthly,
      );

      expect(task.deadlineDate, equals(deadline));
    });
  });
}
