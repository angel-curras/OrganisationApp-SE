import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/controller/module_controller.dart';
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/pages/modules/module_details_page.dart';

class ModuleSearchDelegate extends SearchDelegate {
  final http.Client client;
  final ModuleController _backend;

  ModuleSearchDelegate(this.client, this._backend);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Module>>(
      future: _backend.fetchModuleListWithPaginationAndSorting(
        client,
        searchQuery: query,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No matching courses found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Module module = snapshot.data![index];
              return ListTile(
                title: Text(module.name),
                subtitle: Text(module.verantwortlich),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ModuleDetailsPage(module: module, client: client),
                  ));
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
