import 'package:flutter/material.dart';
import 'package:organisation_app/shared/custom_placeholder.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomPlaceHolder(title: "Calendar");
  }
}
