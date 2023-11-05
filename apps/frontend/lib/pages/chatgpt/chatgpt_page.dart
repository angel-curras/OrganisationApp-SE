import 'package:flutter/material.dart';
import 'package:organisation_app/shared/integrated_browser.dart';

class ChatGptPage extends StatefulWidget {
  const ChatGptPage({super.key});

  @override
  State<ChatGptPage> createState() => _ChatGptPageState();
}

class _ChatGptPageState extends State<ChatGptPage> {
  @override
  Widget build(BuildContext context) {
    return const IntegratedBrowser(title: "Chat", startUrl: 'https://ai.lab.hm.edu');
  }
}
