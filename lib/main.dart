import 'package:flutter/material.dart';
import 'view/home_view.dart';

void main() {
  runApp(const HeartApp());
}

class HeartApp extends StatelessWidget {
  const HeartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heart App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
