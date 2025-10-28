import 'package:flutter/material.dart';
import 'view/home_view.dart';

void main() {
  // the main entry point for entire app
  runApp(const HeartApp());
}

class HeartApp extends StatelessWidget {
  // main/root widget of the screen
  const HeartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heart App', // name of app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // UI look
      ),
      home: const HomeView(), // launch the screen of application
    );
  }
}
