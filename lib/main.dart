import 'package:designaura/src/pages/auth/onboardingScreen.dart';
import 'package:flutter/material.dart';
import 'main_page.dart'; // Import the MainPage widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DesignAura',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(), // Set MainPage as the home widget
    );
  }
}
