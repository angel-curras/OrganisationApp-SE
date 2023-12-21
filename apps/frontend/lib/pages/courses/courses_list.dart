import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/pages/courses/module_details_page.dart';
import 'package:organisation_app/pages/courses/module_search_delegate.dart';
import 'package:organisation_app/services/backend.dart';

import '../../shared/menu_drawer.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late Future<List<Module>> modulesFuture;
  late Backend _backend;
  late http.Client client;

  int currentPage = 0;
  final int pageSize = 10;

  String _sortBy = 'name';
  String _sortDir = 'asc';

  List<Module> modules = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _backend = Backend();
    client = http.Client();
    fetchModules();
  }

  void fetchModules() {
    _backend
        .fetchModuleListWithPaginationAndSorting(
      client,
      page: currentPage,
      size: pageSize,
      sortBy: _sortBy,
      sortDir: _sortDir,
    )
        .then((newModules) {
      setState(() {
        modules.addAll(newModules);
      });
    });
  }

  void _showSearch() {
    showSearch(
      context: context,
      delegate: ModuleSearchDelegate(client, _backend),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return ListView(
              children: [
                ListTile(
                  title: const Text('Sort by Name'),
                  onTap: () => _updateSortOptions('name'),
                ),
                ListTile(
                  title: const Text('Sort by Verantwortlich'),
                  onTap: () => _updateSortOptions('verantwortlich'),
                ),
                ListTile(
                  title: const Text('Sort by ECTS'),
                  onTap: () => _updateSortOptions('ects'),
                ),
                ListTile(
                  title: const Text('Sort by Lehrform'),
                  onTap: () => _updateSortOptions('lehrform'),
                ),
                SwitchListTile(
                  title: const Text('Ascending'),
                  value: _sortDir == 'asc',
                  onChanged: (bool value) {
                    setState(() {
                      _sortDir = value ? 'asc' : 'desc';
                    });
                    _updateSorting();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateSortOptions(String sortBy) {
    setState(() {
      _sortBy = sortBy;
      currentPage = 0;
      modules.clear();
    });
    fetchModules();
    Navigator.pop(context);
  }

  void _updateSorting() {
    setState(() {
      currentPage = 0;
      modules.clear();
      fetchModules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 134, 204),
        title: const Text('Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearch,
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: modules.length + 1,
        itemBuilder: (context, index) {
          if (index < modules.length) {
            Module module = modules[index];
            return Card(
              child: Stack(
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      child: Text(
                        module.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            module.verantwortlich,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[100],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            module.lehrform,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ModuleDetailsPage(module: module),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Text(
                      module.ects.toString(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: OutlinedButton(
                  child: const Text('Load More'),
                  onPressed: () {
                    setState(() {
                      currentPage++;
                      fetchModules();
                    });
                  },
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSortOptions,
        tooltip: 'Sort',
        child: const Icon(Icons.sort),
      ),
      drawer: const MenuDrawer(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
