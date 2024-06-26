import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../controller/task_controller.dart';
import '../../model/task.dart';
import '../../settings/app_settings.dart';
import '../../shared/date_picker.dart';

class CreateItemPage extends StatefulWidget {
  final TaskController _taskController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool edit;
  final Task? task;

  GlobalKey<FormState> get formKey => _formKey;

  CreateItemPage(http.Client client, this.edit, {super.key, this.task})
      : _taskController = TaskController(client: client);

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
    String userName = Provider.of<AppSettings>(context).user.userName;

    if (widget.edit) {
      nameController.text = widget.task!.name;
      priority = widget.task!.priority;
    }
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
      key: const Key("deadline"),
      restorationId: 'deadline',
      onDateSelected: (selectedDate) {
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
      key: const Key("save"),
      onPressed: () async {
        BuildContext initialContext = context;
        if (widget.formKey.currentState!.validate()) {
          if (widget.edit) {
            try {
              // Perform saving action

              Task task = Task(
                id: widget.task!.id,
                name: nameController.text,
                priority: priority,
                deadline: date,
              );
              await widget._taskController.updateTask(task);

              if (!context.mounted) {
                return;
              }
              Navigator.pop(initialContext);
            } catch (error) {
              // Handle error (e.g., display a Snackbar)

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $error'),
                ),
              );
            }
          } else {
            try {
              // Perform saving action
              await widget._taskController.createTask(
                userName,
                nameController.text,
                date,
                priority,
              );

              if (!context.mounted) {
                return;
              }
              Navigator.pop(initialContext);
            } catch (error) {
              // Handle error (e.g., display a Snackbar)

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $error'),
                ),
              );
            }
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
