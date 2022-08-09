import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jow_app/home_page.dart';
//import 'package:untitled37/views/herder_container.dart';
//import 'package:flutterlogindesign/utils/color.dart';

//import 'package:untitled37/views/color.dart';
//impor 'package:untitled37/views/login_page.dart';

class SplashPage extends StatefulWidget {
  @override

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 6000), () {
      Navigator.push(
         context, MaterialPageRoute(builder: (context) => HomePage()));
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                  color: Color.fromARGB(255, 19, 42, 61),
                    child: Center(
                      child: Text(
                        'JAW Radio',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

    );
  }
}