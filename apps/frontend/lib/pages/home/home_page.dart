import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/shared/menu_drawer.dart';
import 'package:provider/provider.dart';

import '../../controller/course_controller.dart';
import '../../model/course.dart';

class MyCoursesPage extends StatefulWidget {
  // Fields.
  final String title = "My Semester";
  late final CourseController _courseController;

  // Constructor.
  MyCoursesPage({super.key, required http.Client client}) {
    _courseController = CourseController(client);
  }

  // Methods.
  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  late final CourseController _courseController;

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
      ),
      body: CoursesListView(courseController: _courseController),

      // Button to add items.
      floatingActionButton: FloatingActionButton(
        tooltip: 'New',
        onPressed: () {
          Navigator.pushNamed(context, '/courses');
        },
        child: const Icon(Icons.add),
      ),
      drawer: const MenuDrawer(),
    );
  }
}

class CoursesListView extends StatelessWidget {
  const CoursesListView({
    super.key,
    required CourseController courseController,
  }) : _courseController = courseController;

  final CourseController _courseController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: _courseController
          .getAllCoursesForUser(context.read<AppSettings>().user.userName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // The future has completed.
          // Return the list of items.
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (_, int position) {
              final course = snapshot.data?[position];
              return CourseCard(course: course);
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
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
  });

  final Course? course;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(course!.name),
        subtitle: Text(course!.responsible),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
              key: Key("edit"),
              icon: Icon(Icons.edit),
              tooltip: 'Edit Item',
              onPressed: () {}),
          IconButton(
            key: Key("delete"),
            icon: Icon(Icons.delete),
            tooltip: 'Delete Item',
            onPressed: () {},
          )
        ]),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('${course!.progress}%'),
        ),
      ),
    );
  }
}
