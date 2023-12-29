import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/controller/task_controller.dart';
import 'package:organisation_app/model/task.dart';
import 'package:organisation_app/shared/menu_drawer.dart';

import 'create_todo_dialog.dart';

class TodosPage extends StatefulWidget {
  // Fields.
  final String title = "ToDo List";
  final TaskController _taskController;

  // Constructor.
  TodosPage({super.key, required http.Client client})
      : _taskController = TaskController(client: client);

  // Methods.
  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  late TaskController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = widget._taskController;
  }

// Todos are displayed with a name, deadline date, Priority and three buttons to edit, delete the item and to check it if you have done it.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 134, 204),
        title: const Center(
          child: Text('ToDo List'),
        ),
      ),
      body: FutureBuilder<List<Task>>(
        future: _taskController.fetchItemList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, int position) {
                final task = snapshot.data?[position];
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      key: Key("doneCheckbox_$position"),
                      value: task!.done,
                      onChanged: (bool? value) {
                        setState(() {
                          task.done = value!;
                          // Update the backend with the 'done' attribute.
                          _taskController.updateTask(
                              task.id,
                              task.name,
                              task.deadline.toString(),
                              task.priority,
                              value,
                              task.frequency);
                        });
                      },
                    ),
                    title: Text(task.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (task.deadline != DateTime(3000, 01, 01))
                          Text("until: "
                              "${task.deadline.day}/${task.deadline.month}/${task.deadline.year}"),
                        Text("Priority: ${task.priority}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          key: const Key("edit"),
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit Item',
                          onPressed: () {
                            showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                child: CreateItemPage(
                                    _taskController.client, true,
                                    task: task),
                              ),
                            ).then((result) {
                              setState(() {});
                            });
                          },
                        ),
                        IconButton(
                          key: const Key("delete"),
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete Item',
                          onPressed: () {
                            setState(() {
                              _taskController.deleteTask(task.id);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New',
        onPressed: () => showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: CreateItemPage(_taskController.client, false),
            );
          },
        ).then((_) => setState(() {})),
        child: const Icon(Icons.add),
      ),
      drawer: const MenuDrawer(),
    );
  }
}
