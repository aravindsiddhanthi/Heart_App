import 'dart:async';
import 'package:flutter/material.dart';
import '../model/heart_state.dart';
import '../services/heart_service.dart'; // DI

class HeartViewModel extends ChangeNotifier {
  final HeartService _service;
  Timer? _timer;
  double progress = 0.0;
  HeartStatus status = HeartStatus.empty;

  // here the entire application logic builds
  HeartViewModel(this._service);

  void toggleFill() {
    if (status == HeartStatus.filling) {
      _timer?.cancel();
      status = HeartStatus.empty;
    } else {
      status = HeartStatus.filling;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        progress = _service.increase(progress);
        // we use heartservice for heart increment logic
        if (progress >= 1.0) {
          _timer?.cancel();
          status = HeartStatus.filled; // controls the heart filling
        }
        // notifies UI when state changes
        notifyListeners();
      }); // Timer.periodic
    }
    notifyListeners();
  }

  //
  void clearHeart() {
    _timer?.cancel();
    progress = 0.0;
    status = HeartStatus.empty;
    notifyListeners(); //
  }
}
