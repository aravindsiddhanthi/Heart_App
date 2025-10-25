import 'dart:async';
import 'package:flutter/material.dart';
import '../model/heart_state.dart';
import '../services/heart_service.dart'; // DI

class HeartViewModel extends ChangeNotifier {
  final HeartService _service;
  Timer? _timer;
  double progress = 0.0;
  HeartStatus status = HeartStatus.empty;
  bool _isRunning = false;

  // here the entire application logic builds
  HeartViewModel(this._service);

  // tap to start or pause the filling
  void toggleFill() {
    if (_isRunning) {
      _pauseFilling();
    } else {
      _startFilling();
    }
  }

  void _startFilling() {
    _isRunning = true;
    status = HeartStatus.filling;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      progress = _service.increase(progress);

      if (progress >= 1.0) {
        progress = 1.0;
        _timer?.cancel();
        _isRunning = false;
        status = HeartStatus.filled;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void _pauseFilling() {
    _timer?.cancel();
    _isRunning = false;
    if (progress == 0.0) {
      status = HeartStatus.empty;
    } else if (progress < 1.0) {
      status = HeartStatus.filling;
    }
    notifyListeners();
  }

  void clearHeart() {
    _timer?.cancel();
    progress = 0.0;
    _isRunning = false;
    status = HeartStatus.empty;
    notifyListeners();
  }
}
