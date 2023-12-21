class Item {
  int id;
  String name;
  DateTime deadline;
  int priority;
  bool done = false;

  Item({
    required this.id,
    required this.name,
    required this.deadline,
    required this.priority,
    required this.done,
  });

  // parse Item from JSON-data
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        deadline: json["deadline"],
        priority: json["priority"],
        done: json["done"],
      );

  get deadlineDate => deadline;

  // map item to JSON-data (so far not used in app)
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deadline": deadline,
        "priority": priority,
        "done": done,
      };
}

//List<Item> itemsFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

//String itemsToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//Item itemFromJson(String str) => Item.fromJson(json.decode(str));

//String itemToJson(Item data) => json.encode(data.toJson());
