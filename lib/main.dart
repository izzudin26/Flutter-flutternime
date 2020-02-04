import 'package:flutter/material.dart';
import 'package:flutternime/ui/homeUi.dart';
import 'package:flutternime/ui/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home()
      }
    );
  }
}
