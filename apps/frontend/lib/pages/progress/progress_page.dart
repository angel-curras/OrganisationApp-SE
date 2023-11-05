import 'package:flutter/material.dart';
import 'package:organisation_app/shared/custom_placeholder.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomPlaceHolder(title: "Progress");
  }
}
