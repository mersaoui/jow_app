import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jow_app/imag.dart';
import 'package:jow_app/img1.dart';
import 'package:jow_app/img3.dart';
import 'package:jow_app/img4.dart';
//import 'package:jow_app/lash.dart';
import 'package:jow_app/screens/home_page.dart';
//import 'package:jow_app/plash.dart';
//import 'package:jow_app/screens/splash_screen.dart';
void main() {
  runApp(
    MyApp(),);

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // >>> use any dependency from your dependency manager <<<
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //statusBarColor: Color.fromARGB(255, 16, 29, 46),  // android statubar
      //systemNavigationBarColor: Color.fromARGB(255, 16, 29, 46) ////  android  navigator bar
      // statusBarIconBrightness: Brightness.light, //android icon batterie ....
        statusBarBrightness: Brightness.dark
    ));
    return MaterialApp(
      title: 'Flutter Demo for imy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
