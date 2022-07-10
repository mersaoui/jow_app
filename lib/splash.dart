import 'package:flutter/material.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(seconds: 4), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
    );
  }
}
