import 'dart:convert';

enum Frequency { once, daily, weekly, monthly }

extension FrequencyExtension on Frequency {
  String toJSON() {
    switch (this) {
      case Frequency.once:
        return 'ONCE';
      case Frequency.daily:
        return 'DAILY';
      case Frequency.weekly:
        return 'WEEKLY';
      case Frequency.monthly:
        return 'MONTHLY';
    }
  }

  static Frequency fromJSON(String frequency) {
    switch (frequency.toUpperCase()) {
      case 'ONCE':
        return Frequency.once;
      case 'DAILY':
        return Frequency.weekly;
      case 'WEEKLY':
        return Frequency.weekly;
      case 'MONTHLY':
        return Frequency.monthly;
      default:
        return Frequency.once;
    }
  }
}

class Task {
  int id;
  String name;
  DateTime? deadline;
  int priority;
  bool done = false;
  Frequency frequency;

  Task({
    this.id = 0,
    this.name = "",
    this.priority = 3,
    this.deadline,
    this.done = false,
    this.frequency = Frequency.once,
  });

  get deadlineDate => deadline;

  // parse Item from JSON-data
  factory Task.fromJsonMap(Map<String, dynamic> json) {
    return Task(
      id: json['task_id'] ?? 0,
      name: json['task_name'] ?? '',
      priority: json['priority'] ?? 3,
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      done: json['is_done'] ?? false,
      frequency: FrequencyExtension.fromJSON(json['frequency'] ?? 'once'),
    );
  }

  // map item to JSON-data (so far not used in app)
  Map<String, dynamic> toJsonMap() => {
        "task_id": id,
        "task_name": name,
        "deadline": deadline?.toIso8601String(),
        "priority": priority,
        "is_done": done,
        "frequency": frequency.toJSON(),
      };

  String toJsonString() => json.encode(toJsonMap());

  factory Task.fromJsonString(String jsonString) =>
      Task.fromJsonMap(json.decode(jsonString));
}
