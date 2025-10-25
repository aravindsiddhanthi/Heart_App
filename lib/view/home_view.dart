import 'dart:async';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _progress = 0.0; // 0 to 1 range
  Timer? _timer;
  bool _isFilling = false;

  // Start or pause the filling inside heart
  void _toggleFill() {
    if (_isFilling) {
      _timer?.cancel();
      setState(() => _isFilling = false);
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_progress < 1.0) {
            _progress += 0.1; // fill 10 % for every each second
          } else {
            _timer?.cancel();
            _isFilling = false;
          }
        });
      });
      setState(() => _isFilling = true);
    }
  }

  void _clearHeart() {
    _timer?.cancel();
    setState(() {
      _progress = 0.0;
      _isFilling = false;
    });
  }

  void _goToSuccessScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SuccessView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _toggleFill,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Heart outline (gray)
                  Icon(Icons.favorite, color: Colors.grey[300], size: 180),
                  // Filled portion
                  ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: _progress,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.deepPurple, // as per given image color
                        size: 180,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "${(_progress * 100).toInt()}%",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            if (_progress == 1.0)
              ElevatedButton(
                onPressed: _clearHeart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(200, 40),
                ),
                child: const Text('Clear'),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _progress == 1.0 ? _goToSuccessScreen : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(200, 40),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

// Separate Success screen
class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SUCCESS!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
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
