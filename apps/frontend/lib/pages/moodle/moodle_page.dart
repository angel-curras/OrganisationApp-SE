import 'package:flutter/material.dart';
import 'package:organisation_app/shared/integrated_browser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoodlePage extends StatelessWidget {
  MoodlePage({super.key, WebViewController? webViewController})
      : _webViewController = webViewController ?? WebViewController();
  final WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return IntegratedBrowser(
        title: "Moodle",
        startUrl: 'https://moodle.hm.edu/?lang=de',
        webViewController: _webViewController);
  }
}
