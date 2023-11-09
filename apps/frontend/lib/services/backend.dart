import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organisation_app/model/item.dart';

class Backend {
  // use IP 10.0.2.2 to access localhost from windows client / iPhone emulator
  static const _backend = "http://127.0.0.1:8080/";

  // use IP 10.0.2.2 to access localhost from emulator!
  // static const _backend = "http://10.0.2.2:8080/";

  // use custom IP 10.0.2.2 to access the endpoint from a real phone!
  // static const _backend = "http://192.168.178.22:8080/";

  // use custom IP 10.0.2.2 to access the endpoint from a real phone!
  // static const _backend = "http://10.181.91.20:8080/";

  // get item list from backend
  Future<List<Item>> fetchItemList(http.Client client) async {
    // access REST interface with get request
    final response = await client.get(Uri.parse('${_backend}items'));

    // check response from backend
    if (response.statusCode == 200) {
      return List<Item>.from(json
          .decode(utf8.decode(response.bodyBytes))
          .map((x) => Item.fromJson(x)));
    } else {
      throw Exception('Failed to load Itemlist');
    }
  }

  // save new item on backend
  Future<Item> createItem(
      http.Client client, String name, String description) async {
    Map data = {
      'name': name,
      'description': description,
    };

    // access REST interface with post request
    var response = await client.post(Uri.parse('${_backend}item'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

    // check response from backend
    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to create item');
    }
  }

  // Update item on backend
  Future<void> updateItem(
      http.Client client, int id, String name, String description) async {
    Map data = {
      'id': id,
      'name': name,
      'description': description,
    };

    // access REST interface with put request
    var response = await client.put(Uri.parse('${_backend}item'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

// check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  // delete item on backend
  Future<void> deleteItem(http.Client client, int id) async {
    Map data = {
      'id': id,
    };

    // access REST interface with delete request
    var response = await client.delete(Uri.parse('${_backend}item'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode(data));

    // check response from backend
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}
