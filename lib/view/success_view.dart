import 'package:flutter/material.dart';

// success screen gets after the heart gets filled 100% with navigation back option exists

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // center success message and also the back button
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SUCCESS!', // success text message
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              // here is the back button that will erturn to the heart screen
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(200, 40),
              ),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
