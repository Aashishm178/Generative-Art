import 'package:flutter/material.dart';
import 'package:generative_art/generative_art.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: AnimatedRing(
          noOfRings: 100,
          child: Container(),
        ),
      ),
    );
  }
}
