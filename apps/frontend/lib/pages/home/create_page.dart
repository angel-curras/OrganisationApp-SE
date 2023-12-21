import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/services/backend.dart';

// widget class to create stateful new item page
class CreateItemPage extends StatefulWidget {
  final Backend _backend;
  final http.Client _client;

  const CreateItemPage(this._backend, this._client);

  Backend get backend => _backend;

  http.Client get client => _client;

  @override
  CreateItemPageState createState() {
    return CreateItemPageState();
  }
}

class CreateItemPageState extends State<CreateItemPage> {
  // Key to access HTTP Form state
  final _formKey = GlobalKey<FormState>();

  // necessary for mocking (unit and widget tests)
  late Backend _backend; // library with functions to access backend
  late http.Client _client; // REST client proxy

  @override
  void initState() {
    super.initState();
    _backend = widget._backend;
    _client = widget._client;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    final nameField = TextFormField(
      key: Key("name"),
      controller: nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: "Please enter item name"),
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Error: please enter item name';
        }
        return null;
      },
    );

    final descriptionField = TextFormField(
      key: Key("desc"),
      controller: descriptionController,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Please enter item description",
      ),
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Error: please enter item description';
        }
        return null;
      },
    );

    final saveButton = ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _backend
              .createItem(_client, nameController.text, "2021-01-01", 3, false)
              .then((value) => Navigator.pop(context));
        }
      },
      child: Text('Create'),
    );

    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        children: <Widget>[nameField, descriptionField, saveButton],
      ),
    );
  }
}
