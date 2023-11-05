import 'package:flutter/material.dart';
import 'package:organisation_app/shared/custom_placeholder.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomPlaceHolder(title: "Courses");
  }
}
