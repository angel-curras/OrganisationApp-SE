import 'package:flutter/material.dart';
import 'package:organisation_app/shared/integrated_browser.dart';

class MoodlePage extends StatefulWidget {
  const MoodlePage({super.key});

  @override
  State<MoodlePage> createState() => _MoodlePageState();
}

class _MoodlePageState extends State<MoodlePage> {
  @override
  Widget build(BuildContext context) {
    return const IntegratedBrowser(title: "Moodle", startUrl: 'https://moodle.hm.edu/?lang=de');
  }
}
