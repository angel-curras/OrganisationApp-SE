import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/services/backend.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/shared/menu_drawer.dart';
import 'package:organisation_app/shared/user_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // Fields.
  final String title = "My Semester";
  final http.Client client = http.Client();

  // Constructor.
  HomePage({super.key});

  // Methods.
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // necessary for mocking (unit and widget tests)
  late Backend _backend; // library with functions to access backend
  late http.Client _client; // REST client proxy

  @override
  void initState() {
    super.initState();
    _backend = Backend();
    _client = widget.client;

    // Post creation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isUserLoggedIn();
    });
  }

  void isUserLoggedIn() {
    bool result = context.read<AppSettings>().isUserLoggedIn();

    if (!result) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 134, 204),
        title: const Center(
          child: Text('My Semester'),
        ),
      ),

      // body: FutureBuilder<List<Item>>(
      //   future: _backend.fetchItemList(http.Client()),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       // The future has completed.
      //       // Return the list of items.
      //       return ListView.builder(
      //         itemCount: snapshot.data?.length,
      //         itemBuilder: (_, int position) {
      //           final item = snapshot.data?[position];
      //           return Card(
      //             child: ListTile(
      //               title: Text(item!.name),
      //               subtitle: Text(item.description),
      //               trailing:
      //                   Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      //                 IconButton(
      //                     key: Key("edit"),
      //                     icon: Icon(Icons.edit),
      //                     tooltip: 'Edit Item',
      //                     onPressed: () {
      //                       showDialog<bool>(
      //                         context: context,
      //                         builder: (BuildContext context) => Dialog(
      //                           child: UpdateItemPage(_backend, _client, item),
      //                         ),
      //                       ).then((result) {
      //                         print("Item was edited!");
      //                         setState(() {});
      //                       });
      //                     }),
      //                 IconButton(
      //                   key: Key("delete"),
      //                   icon: Icon(Icons.delete),
      //                   tooltip: 'Delete Item',
      //                   onPressed: () {
      //                     print("Delete Item");
      //                     setState(() {
      //                       _backend.deleteItem(_client, item.id);
      //                     });
      //                   },
      //                 )
      //               ]),
      //             ),
      //           );
      //         },
      //       );
      //     } else if (snapshot.hasError) {
      //       // The future has completed with an error.
      //       return Text('${snapshot.error}');
      //     } else {
      //       // The future is still in progress.
      //       // Return the progress indicator widget.
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),

      // Button to add items.
      floatingActionButton: FloatingActionButton(
        tooltip: 'New',
        onPressed: () => (),
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CreateItemPage(_backend, _client),
        //   ),
        // ).then((_) => setState(() {}));

        // onPressed: () => showDialog<bool>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return Dialog(
        //       child: CreateItemPage(_backend, _client),
        //     );
        //   },
        // ).then((_) => setState(() {})),
        child: const Icon(Icons.add),
      ),
      drawer: const MenuDrawer(),
      endDrawer: const UserDrawer(),
    );
  }
}
