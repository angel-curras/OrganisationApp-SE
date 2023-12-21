class Task {
  int id;
  String name;
  DateTime deadline;
  int priority;
  bool done = false;
  String frequency;

  Task({
    required this.id,
    required this.name,
    required this.priority,
    required this.deadline,
    required this.done,
    required this.frequency,
  });

  // parse Item from JSON-data
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      priority: json['priority'] ?? 3,
      deadline: DateTime.parse(json['deadline']),
      done: json['done'] ?? false,
      frequency: json['frequency'] ?? 'once',
    );
  }

  get deadlineDate => deadline;

  // map item to JSON-data (so far not used in app)
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deadline": deadline.toIso8601String(),
        "priority": priority,
        "done": done,
        "frequency": frequency,
      };
}
