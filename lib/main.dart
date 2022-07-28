import 'package:flutter/material.dart';
import 'package:jow_app/screens/home_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 18, 38, 56),
        systemNavigationBarColor: Color.fromARGB(255, 18, 38, 56)));
    return MaterialApp(
      title: 'Flutter Demo for imy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
