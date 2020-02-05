import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void startTime() async {
    final duration = Duration(seconds: 3);
    Timer(duration, navigatorPage);
  }

  void navigatorPage(){
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void initState(){
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('image/splash.png',scale: 2.5),
            SizedBox(
              height: 20,
            ),
            Text('FLUTTERNIME', style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text('PLEASE WAIT')
          ],
        ),
      ),
    );
  }
}