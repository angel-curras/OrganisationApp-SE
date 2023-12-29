import 'package:flutter/material.dart';
import 'package:organisation_app/shared/integrated_browser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrimussPage extends StatelessWidget {
  PrimussPage({super.key, WebViewController? webViewController})
      : _webViewController = webViewController ?? WebViewController();
  final WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return IntegratedBrowser(
        title: "Primuss",
        startUrl: 'https://www.primuss.de/portal-fhm',
        webViewController: _webViewController);
  }
}
