// Mock class for WebViewPlatform
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class MockPlatformWebViewCookieManager extends PlatformWebViewCookieManager {
  MockPlatformWebViewCookieManager()
      : super.implementation(
            const PlatformWebViewCookieManagerCreationParams());

  @override
  Future<bool> clearCookies() {
    return Future.value(true);
  }

  @override
  Future<void> setCookie(WebViewCookie cookie) {
    return Future.value();
  }
}

class MockPlatformWebViewWidget extends PlatformWebViewWidget {
  MockPlatformWebViewWidget()
      : super.implementation(PlatformWebViewWidgetCreationParams(
            controller: MockPlatformWebViewController()));

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MockPlatformWebViewController extends PlatformWebViewController {
  MockPlatformWebViewController()
      : super.implementation(const PlatformWebViewControllerCreationParams());

  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) {
    return Future.value();
  }

  @override
  Future<void> setPlatformNavigationDelegate(
      PlatformNavigationDelegate handler) {
    return Future.value();
  }

  @override
  Future<void> loadRequest(
    LoadRequestParams params,
  ) {
    return Future.value();
  }
}

class MockPlatformNavigationDelegate extends PlatformNavigationDelegate {
  MockPlatformNavigationDelegate()
      : super.implementation(const PlatformNavigationDelegateCreationParams());

  @override
  Future<void> setOnNavigationRequest(
    NavigationRequestCallback onNavigationRequest,
  ) {
    return Future.value();
  }

  @override
  Future<void> setOnPageStarted(
    PageEventCallback onPageStarted,
  ) {
    return Future.value();
  }

  @override
  Future<void> setOnPageFinished(
    PageEventCallback onPageFinished,
  ) {
    return Future.value();
  }

  @override
  Future<void> setOnHttpError(
    HttpResponseErrorCallback onHttpError,
  ) {
    return Future.value();
  }

  @override
  Future<void> setOnProgress(
    ProgressCallback onProgress,
  ) {
    return Future.value();
  }

  @override
  Future<void> setOnWebResourceError(
    WebResourceErrorCallback onWebResourceError,
  ) {
    return Future.value();
  }

  @override
  Future<void> setOnUrlChange(UrlChangeCallback onUrlChange) {
    return Future.value();
  }

  @override
  Future<void> setOnHttpAuthRequest(HttpAuthRequestCallback onHttpAuthRequest) {
    return Future.value();
  }
}

class MockWebViewPlatform extends WebViewPlatform {
  @override
  PlatformWebViewCookieManager createPlatformCookieManager(
      PlatformWebViewCookieManagerCreationParams params) {
    return MockPlatformWebViewCookieManager();
  }

  @override
  PlatformWebViewWidget createPlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams params) {
    return MockPlatformWebViewWidget();
  }

  @override
  PlatformWebViewController createPlatformWebViewController(
      PlatformWebViewControllerCreationParams params) {
    return MockPlatformWebViewController();
  }

  @override
  PlatformNavigationDelegate createPlatformNavigationDelegate(
      PlatformNavigationDelegateCreationParams params) {
    return MockPlatformNavigationDelegate();
  }
}
