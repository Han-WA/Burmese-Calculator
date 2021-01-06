import 'package:flutter/material.dart';
import 'landingscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF020316),
        accentColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF0f1437),
      ),
      home: LandingScreen(),
    );
  }
}
