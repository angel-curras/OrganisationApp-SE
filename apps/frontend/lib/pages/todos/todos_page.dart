import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/model/item.dart';
import 'package:organisation_app/services/backend.dart';
import 'package:organisation_app/shared/menu_drawer.dart';
import 'package:organisation_app/shared/user_drawer.dart';

import '../home/create_page.dart';
import 'update_page.dart';

class TodosPage extends StatefulWidget {
  // Fields.
  final String title = "Organisation App";
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

      body: FutureBuilder<List<Item>>(
        future: _backend.fetchItemList(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // The future has completed.
            // Return the list of items.
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, int position) {
                final item = snapshot.data?[position];
                return Card(
                  child: ListTile(
                    title: Text(item!.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "deadline: ${item.deadline.day}/${item.deadline.month}/${item.deadline.year}"),
                        Text("Priority: ${item.priority}"),
                      ],
                    ),
                    trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      IconButton(
                          key: const Key("edit"),
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit Item',
                          onPressed: () {
                            showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                child: UpdateItemPage(_backend, _client, item),
                              ),
                            ).then((result) {
                              print("Item was edited!");
                              setState(() {});
                            });
                          }), //CheckBox to check if you have done the item
                      /*IconButton(
                          key: Key("check"),
                          icon: Icon(Icons.check),
                          tooltip: 'Check Item',
                          onPressed: () {
                            print("Check Item");
                            setState(() {
                              _backend.checkItem(_client, item.id);
                            });
                          }),*/
                      IconButton(
                        key: const Key("delete"),
                        icon: const Icon(Icons.delete),
                        tooltip: 'Delete Item',
                        onPressed: () {
                          print("Delete Item");
                          setState(() {
                            _backend.deleteItem(_client, item.id);
                          });
                        },
                      )
                    ]),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // The future has completed with an error.
            return Text('${snapshot.error}');
          } else {
            // The future is still in progress.
            // Return the progress indicator widget.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      // Button to add items.
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
      endDrawer: const UserDrawer(),
    );
  }
}
