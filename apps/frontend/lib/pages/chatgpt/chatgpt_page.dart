import 'package:flutter/material.dart';
import 'package:organisation_app/shared/integrated_browser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatGptPage extends StatelessWidget {
  ChatGptPage({super.key, WebViewController? webViewController})
      : _webViewController = webViewController ?? WebViewController();
  final WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return IntegratedBrowser(
        title: "Chat",
        startUrl: 'https://ai.lab.hm.edu',
        webViewController: _webViewController);
  }
}
