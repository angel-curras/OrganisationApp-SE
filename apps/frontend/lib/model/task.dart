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
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        name: json["name"],
        deadline: json["deadline"],
        priority: json["priority"],
        done: json["done"],
        frequency: json["frequency"],
      );

  get deadlineDate => deadline;

  // map item to JSON-data (so far not used in app)
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deadline": deadline,
        "priority": priority,
        "done": done,
        "frequency": frequency,
      };
}
