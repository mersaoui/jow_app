import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  double progressNumber = 0;
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,height: 300, decoration:BoxDecoration(color: Colors.blueGrey),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                      color: Colors.amberAccent, value: progressNumber),
                  Container(
                    height: 180,
                    width: 180,
                    color: Colors.blue,
                  ),
                  Container(
                    child: Text('JOW RADIO',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Color.fromARGB(255, 15, 60, 97),
                            color: Colors.white)),
                  ),

                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: WebView(
                onPageFinished: (state) {
                  print('onPageloaded state: $state');
                  setState(() {
                    isLoading = false;
                  });
                },
                onPageStarted: (state) {
                  print('onPageStarted state: $state');
                  isLoading = true;
                },
                onProgress: (progress) {
                  setState(
                        () {
                      progressNumber = progress.toDouble();
                    },
                  );
                },
                initialUrl: 'https://jow.plus/live-meta/jow-charki',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (_webViewController) =>
                webViewController = _webViewController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
