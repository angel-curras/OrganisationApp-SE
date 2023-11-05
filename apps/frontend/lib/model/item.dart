
class Item {
    int id;
    String name;
    String description;

    Item({
        required this.id,
        required this.name,
        required this.description,
    });

    // parse Item from JSON-data
    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    // map item to JSON-data (so far not used in app)
    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}

//List<Item> itemsFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

//String itemsToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//Item itemFromJson(String str) => Item.fromJson(json.decode(str));

//String itemToJson(Item data) => json.encode(data.toJson());

