import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  // static UI
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout for the screen
      appBar: AppBar(
        title: const Text('Heart Monitor'),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: const Center(
        child: Text(
          'Heart App ',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
