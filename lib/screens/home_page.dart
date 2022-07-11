import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (await _webViewController.canGoBack()) {
              _webViewController.goBack();
              return false;
            } else {
              return true;
            }
          },
          child: WebView(
            initialUrl: 'https://jow.plus/live-meta/jow-charki',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewController) =>
            _webViewController = webViewController,
          ),
        ),
      ),
    );
  }
}
