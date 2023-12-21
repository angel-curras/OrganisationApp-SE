import 'package:flutter/material.dart';
import 'package:organisation_app/shared/menu_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IntegratedBrowser extends StatefulWidget {
  final String title;
  final String startUrl;

  const IntegratedBrowser(
      {super.key, required this.title, required this.startUrl});

  @override
  State<IntegratedBrowser> createState() => _IntegratedBrowserState();
}

class _IntegratedBrowserState extends State<IntegratedBrowser> {
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

  @override
  void initState() {
    super.initState();
    _controller.loadRequest(Uri.parse(widget.startUrl));
  }

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
      body: WebViewWidget(controller: _controller),
    );
  }
}
