import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/controller/task_controller.dart';
import 'package:organisation_app/model/task.dart';

// widget class to create stateful new item page
class UpdateItemPage extends StatefulWidget {
  final TaskController _taskController;
  final Task item;

  UpdateItemPage(http.Client client, this.item, {super.key})
      : _taskController = TaskController(client: client);

  @override
  UpdateItemPageState createState() {
    return UpdateItemPageState();
  }
}

class UpdateItemPageState extends State<UpdateItemPage> {
  // Key to access HTTP Form state
  final _formKey = GlobalKey<FormState>();

  // necessary for mocking (unit and widget tests)
  late Task item;
  late TaskController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = widget._taskController;
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    nameController.text = item.name;

    final nameField = TextFormField(
      key: const Key("name"),
      controller: nameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(hintText: "Please enter item name"),
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Error: please enter item name';
        }
        return null;
      },
    );

    final saveButton = ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _taskController
              .updateTask(item.id, nameController.text, "3", item.priority)
              .then((value) => Navigator.pop(context));
        }
      },
      child: const Text('Update'),
    );

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        children: <Widget>[nameField, saveButton],
      ),
    );
  }
}
