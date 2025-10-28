import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/heart_viewmodel.dart';
import '../services/heart_service.dart';
import '../model/heart_state.dart';
import 'success_view.dart';

//Injects heartviewmodel with heartservice (DI)

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
  // main Heart screen
  const HeartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context
        .watch<HeartViewModel>(); // here connects view with viewmodel

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          vm.status.name
              .toUpperCase(), // shows the current heart state (like Empty,Filling,Filled,Success)
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
              onTap: vm.toggleFill, // starts or pause fills the heart
              child: ClipPath(
                clipper: HeartClipper(), // limits shader to heart shape only
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0, vm.progress],
                      colors: const [Colors.deepPurple, Colors.grey],
                    ).createShader(bounds);
                  },
                  blendMode:
                      BlendMode.srcATop, // apply shader inside heart only
                  child: Container(
                    width: 220,
                    height: 220,
                    color: Colors
                        .grey[300], // base heart color which is empty heart
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            // fill the percentage display comes from  here
            Text(
              "${(vm.progress * 100).toInt()}%",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),

            if (vm.status ==
                HeartStatus
                    .filled) //clear button , visible after 100% heart filled
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
              // next button navigates to Successview
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

// custom heart shape path
class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    path.moveTo(width / 2, height); // Starts from the  bottom tip of heart
    path.cubicTo(
      0,
      height * 0.75,
      0,
      height * 0.25,
      width / 2,
      height * 0.4,
    ); // Left half of heart
    // Right half of heart
    path.cubicTo(width, height * 0.25, width, height * 0.75, width / 2, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
