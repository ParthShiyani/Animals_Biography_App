import 'package:animal_biography/screens/home_page.dart';
import 'package:animal_biography/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash_screen",
      routes: {
        "/": (context) => const HomePage(),
        "splash_screen": (context) => const SplashScreen(),
      },
    ),
  );
}
