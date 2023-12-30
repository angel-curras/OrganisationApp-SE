import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:organisation_app/pages/my_courses/update_course_dialog.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/shared/menu_drawer.dart';
import 'package:provider/provider.dart';

import '../../controller/course_controller.dart';
import '../../model/course.dart';

class MyCoursesPage extends StatefulWidget {
  // Fields.
  late final CourseController _courseController;

  // Constructor.
  MyCoursesPage({super.key, http.Client? client}) {
    _courseController = CourseController(client: client ?? http.Client());
  }

  // Methods.
  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  static final Logger _logger = Logger();
  late final CourseController _courseController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _courseController = widget._courseController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 134, 204),
        title: const Text('My Courses'),
        actions: [
          IconButton(
            key: const Key("update"),
            icon: const Icon(Icons.update),
            tooltip: 'Edit Item',
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Course>>(
        future: _courseController
            .getAllCoursesForUser(context.read<AppSettings>().user.userName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // The future is complete.
            List<Course> courses = snapshot.data ?? [];
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (_, int position) {
                final course = courses[position];
                return GestureDetector(
                  onTap: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return UpdateCourseDialog(
                            client: _courseController.client, course: course);
                      },
                    );
                    setState(() {});
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(course.name),
                      subtitle: Text(course.responsible),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              key: const Key("delete"),
                              icon: const Icon(Icons.delete),
                              tooltip: 'Delete Item',
                              onPressed: () async {
                                await _courseController.deleteCourse(course);
                                setState(() {});
                              },
                            )
                          ]),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        child: Text('${course.progress}%'),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            // The future has completed with an error.
            return Text('${snapshot.error}');
          }

          // The future is still in progress.
          // Return the progress indicator widget.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      // Button to add items.
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'New',
        onPressed: () {
          Navigator.pushNamed(context, '/modules');
        },
        icon: const Icon(Icons.add),
        label: const Text('Course'),
      ),
      drawer: const MenuDrawer(),
    );
  } // end of build()
} // end of class MyCoursesPage
