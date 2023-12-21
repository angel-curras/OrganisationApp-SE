import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/services/backend.dart';

import 'date_picker.dart';

class CreateItemPage extends StatefulWidget {
  final Backend _backend;
  final http.Client _client;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreateItemPage(this._backend, this._client, {Key? key}) : super(key: key);

  Backend get backend => _backend;

  http.Client get client => _client;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  CreateItemPageState createState() {
    return CreateItemPageState();
  }
}

class CreateItemPageState extends State<CreateItemPage> {
  final TextEditingController nameController = TextEditingController();
  int priority = 3; // Set a default priority value
  DateTime date = DateTime(3000, 01, 01);
  bool done = false;

  @override
  Widget build(BuildContext context) {
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

    var deadlineField = DatePickerTask(
      restorationId: 'deadline',
      onDateSelected: (selectedDate) {
        // Do something with the selectedDate, e.g., assign it to yourVar
        date = selectedDate;
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
          priority = newValue ?? 3; // Set a default value if null
        });
      },
      items: [1, 2, 3].map((int value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );

    final saveButton = ElevatedButton(
      onPressed: () async {
        if (widget.formKey.currentState!.validate()) {
          try {
            // Perform saving action
            await widget.backend.createTask(
              widget.client,
              nameController.text,
              date.toIso8601String(),
              priority,
              done,
              "once",
            );
            Navigator.pop(context);
          } catch (error) {
            // Handle error (e.g., display a Snackbar)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $error'),
              ),
            );
          }
        }
      },
      child: const Text('Save'),
    );

    return Form(
      key: widget.formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          nameField,
          deadlineField,
          priorityField,
          saveButton,
        ],
      ),
    );
  }
}
