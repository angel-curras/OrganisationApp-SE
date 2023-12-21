import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/services/backend.dart';

import '../home/create_page.dart';
import 'DatePickerExample.dart';

// widget class to create stateful new item page
class CreateItemPageState extends State<CreateItemPage> {
  // Key to access HTTP Form state
  final _formKey = GlobalKey<FormState>();
  late Backend backend;
  late http.Client client;

  // Move the variables here to maintain their state across rebuilds
  final TextEditingController nameController = TextEditingController();
  int priority = 3;
  DateTime date = DateTime(3000, 01, 01); // The year should be first
  bool done = false;

  @override
  void initState() {
    super.initState();
    backend = widget.backend;
    client = widget.client;
  }

  @override
  Widget build(BuildContext context) {
    // Now that variables are moved outside build, don't redefine them here

    final nameField = TextFormField(
      key: const Key("name"),
      controller: nameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(hintText: "Please enter Task name"),
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Error: please enter Task name';
        }
        return null;
      },
    );

    var deadlineField = DatePickerExample(
      onDateSelected: (selectedDate) {
        setState(() {
          date = selectedDate;
        });
      },
    );

    var doneField = Checkbox(
      value: done,
      onChanged: (bool? value) {
        setState(() {
          done = value ?? done;
        });
      },
    );

    var priorityField = DropdownButtonFormField(
      key: const Key("priority"),
      value: priority,
      decoration: const InputDecoration(
        hintText: "Please select priority",
      ),
      onChanged: (int? newValue) {
        setState(() {
          priority = newValue ?? priority;
        });
      },
      items: [1, 2, 3, 4].map((int value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );

    final saveButton = ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Perform saving action
          backend
              .createItem(client, nameController.text, date.toIso8601String(),
                  priority, done)
              .then((value) => Navigator.pop(context));
        }
      },
      child: const Text('Save'),
    );

    // Use Form with the global key
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          nameField,
          saveButton,
          deadlineField,
          priorityField,
          doneField,
        ],
      ),
    );
  }
}
