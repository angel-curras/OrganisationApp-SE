import 'package:flutter/material.dart';
import 'package:organisation_app/shared/menu_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IntegratedBrowser extends StatelessWidget {
  final String _title;
  final String _startUrl;
  final WebViewController _webViewController;

  const IntegratedBrowser(
      {super.key,
      required String title,
      required String startUrl,
      required WebViewController webViewController})
      : _startUrl = startUrl,
        _title = title,
        _webViewController = webViewController;

  @override
  Widget build(BuildContext context) {
    _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    _webViewController.loadRequest(Uri.parse(_startUrl));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 134, 204),
        title: Text(_title),
      ),
      drawer: const MenuDrawer(),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
