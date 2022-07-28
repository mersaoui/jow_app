import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isOffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isOffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isOffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isOffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          isOffline = false;
        });
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
        child: Container(
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: !isOffline
              ? WebView(
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
                        print('progress: $progressNumber');
                      },
                    );
                  },
                  initialUrl: 'https://jow.plus/live-meta/jow-charki',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (_webViewController) =>
                      webViewController = _webViewController,
                )
              : Container(
                  child: Text("Offline"),
                ),
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
