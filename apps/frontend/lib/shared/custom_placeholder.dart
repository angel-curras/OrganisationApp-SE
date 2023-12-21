import 'package:flutter/material.dart';
import 'package:organisation_app/shared/menu_drawer.dart';

class CustomPlaceHolder extends StatefulWidget {
  final String title;

  const CustomPlaceHolder({super.key, required this.title});

  @override
  State<CustomPlaceHolder> createState() => _CustomPlaceHolderState();
}

class _CustomPlaceHolderState extends State<CustomPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 134, 204),
        title: Center(
          child: Text(widget.title),
        ),
      ),
      drawer: const MenuDrawer(),
      body: Center(child: Text("Placeholder for ${widget.title}")),
    );
  }
}
