import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jow_app/splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';



void main() {


  runApp(
    MyApp(),
  );
}
//FlutterNativeSplash.remove();
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
        statusBarBrightness: Brightness.dark));
    return OverlaySupport.global(
        child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),);
  }
}
