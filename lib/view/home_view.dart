import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/heart_viewmodel.dart';
import '../services/heart_service.dart';
import '../model/heart_state.dart';
import 'success_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HeartViewModel(HeartService()),
      child: const HeartScreen(),
    );
  }
}

class HeartScreen extends StatelessWidget {
  const HeartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HeartViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          vm.status.name.toUpperCase(), // shows Empty,Filling,Filled,Success
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: vm.toggleFill,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.favorite, color: Colors.grey[300], size: 180),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: vm.progress, // 0.0 → 1.0
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.deepPurple,
                        size: 180,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "${(vm.progress * 100).toInt()}%",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            if (vm.status == HeartStatus.filled)
              ElevatedButton(
                onPressed: vm.clearHeart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(200, 40),
                ),
                child: const Text('Clear'),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: vm.status == HeartStatus.filled
                  ? () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SuccessView()),
                    )
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: vm.status == HeartStatus.filled
                    ? Colors.blue
                    : Colors.grey[300],
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
