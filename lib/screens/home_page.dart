import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  double progressNumber = 0;
  late WebViewController webViewController;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isOffline = false;

  @override
  initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        if (result != ConnectivityResult.none) {
          isOffline = await InternetConnectionChecker().hasConnection;

          if (isOffline) {
            setState(() {
              isOffline = true;
            });
          } else {
            setState(() {
              isOffline = false;
            });
          }
        }
      }
    });
  }

  @override
  dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Stack(
                children: [
                  WebView(
                    onPageFinished: (state) {
                      webViewController
                          .runJavascript("window.backgroundMusic.play()");
                    },
                    onProgress: (progress) {
                      setState(
                        () {
                          progressNumber = progress.toDouble();
                          print('progress: $progressNumber');
                        },
                      );
                    },
                    initialUrl: 'https://jow.plus/app-ios',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (_webViewController) =>
                        webViewController = _webViewController,
                    allowsInlineMediaPlayback: true,
                    initialMediaPlaybackPolicy:
                        AutoMediaPlaybackPolicy.always_allow,
                  ),
                  /*isOffline
                              ? Expanded(
                                  child: Center(
                                    child: Container(
                                      child: Text(
                                        "Offline",
                                        style: TextStyle(fontSize: 30.0),
                                      ),
                                    ),
                                  ),
                                )
                              : Container()*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
}
