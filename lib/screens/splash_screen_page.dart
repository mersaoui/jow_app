import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jow_app/home_page.dart';

//doesnt work

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: new Image.asset(
                'assets/jow.png',
                width: size.width,
                height: size.height,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {


    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        ModalRoute.withName("/login"));

  }
}