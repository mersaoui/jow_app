import 'dart:async';
//import 'dart:developer' as developer;
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'dart:io';
//import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  double progressNumber = 0;
  late WebViewController webViewController;

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
            print('no internet');
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }




  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 19, 42, 61),
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                onPageFinished: (finished) {
                  setState(
                        () {
                      print('finished $finished');
                      isLoading = false;
                      //await _controller?.evaluateJavascript("document.getElementsByTagName('main')[0].style.display ='none'');
                    },
                  );
                },

                onProgress: (progress) {
                  setState(
                        () {
                      progressNumber = progress.toDouble();
                      print('progress: $progressNumber');
                      if (progress > 88) {
                        isLoading = false;
                      }
                    },
                  );
                },



                //https://fastdeliveryjow.bubbleapps.io/version-test?debug_mode=true
                //https://jow.plus/app-ios
                initialUrl: 'https://jow.plus/app-ios',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (_webViewController) =>
                webViewController = _webViewController,
                allowsInlineMediaPlayback: true,
                initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy
                    .always_allow,
                backgroundColor: Color.fromARGB(255, 19, 41, 59),
              ),
              if (isLoading)
                Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        //color: Color.fromRGBO(20, 172, 168, 1),
                        color: Color.fromARGB(255, 19, 42, 61),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 60.0,
                                  child: new Image.asset ('assets/jow.png',
                                    width: 70,
                                    height: 90,
                                  ),),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                ),
                                Text(
                                  'JOW RADIO',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.yellow,
                                size: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                              ),
                              Text(
                                'Loding, Please Wait...',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),

            ],

          ),
        ),
      );
    }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false && (progressNumber < 5)) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
  }
