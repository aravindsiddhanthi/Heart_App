import 'package:flutter/material.dart';
import 'view/home_view.dart';

void main() {
  // entry point
  runApp(const HeartApp());
}

//  here is the main app widget
class HeartApp extends StatelessWidget {
  //
  const HeartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // here the debug label will get removed
      title: 'Heart App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo.shade900,
        ), // as per given instructions
        useMaterial3: true, // enables modern UI styling
      ),
      home: const HomeView(), // our first screen
    );
  }
}
