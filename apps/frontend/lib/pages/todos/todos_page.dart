import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/model/task.dart';
import 'package:organisation_app/services/backend.dart';
import 'package:organisation_app/shared/menu_drawer.dart';

import 'create_todo_dialog.dart';
import 'edit_todo_dialog.dart';

class TodosPage extends StatefulWidget {
  // Fields.
  final String title = "ToDos";
  final Backend backend = Backend();
  final http.Client client = http.Client();

  // Constructor.
  TodosPage({super.key});

  // Methods.
  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  // necessary for mocking (unit and widget tests)
  late Backend _backend; // library with functions to access backend
  late http.Client _client; // REST client proxy

  @override
  void initState() {
    super.initState();
    _backend = widget.backend;
    _client = widget.client;
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
        future: _backend.fetchItemList(_client),
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
                          _backend.updateItemDoneStatus(
                              _client, task.id, value);
                        });
                      },
                    ),
                    title: Text(task.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Frequency: ${task.frequency}"),
                        Text(
                            "deadline: ${task.deadline.day}/${task.deadline.month}/${task.deadline.year}"),
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
                                child: UpdateItemPage(_backend, _client, task),
                              ),
                            ).then((result) {
                              print("Item was edited!");
                              setState(() {});
                            });
                          },
                        ),
                        IconButton(
                          key: const Key("delete"),
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete Item',
                          onPressed: () {
                            print("Delete Item");
                            setState(() {
                              _backend.deleteTask(_client, task.id);
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
              child: CreateItemPage(_backend, _client),
            );
          },
        ).then((_) => setState(() {})),
        child: const Icon(Icons.add),
      ),
      drawer: const MenuDrawer(),
    );
  }
}
