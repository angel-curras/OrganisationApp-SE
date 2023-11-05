import 'package:flutter/material.dart';
import 'package:organisation_app/shared/custom_placeholder.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomPlaceHolder(title: "ToDos");
  }
}
