import 'dart:async';
import 'package:flutter/material.dart';
import '../model/heart_state.dart';
import '../services/heart_service.dart'; // DI

// view model layer contains entire bussinees logic for Heart App
// mainly handles the user actions, timer updates and state persistence

class HeartViewModel extends ChangeNotifier {
  final HeartService _service;
  Timer? _timer;
  double progress = 0.0;
  HeartStatus status = HeartStatus.empty;
  bool _isRunning = false; // tap toggles filling
  bool get isRunning => _isRunning; // add getter for testing purpose

  // here the entire application logic builds which initializes viewmodel
  HeartViewModel(this._service) {
    _loadSavedState(); // here it will laod the pervious state
  }

  Future<void> _loadSavedState() async {
    // Loads saved progress and status from storage
    final saved = await _service.loadstate();
    progress = saved['progress'];
    status = saved['status'];
    notifyListeners();
  }

  // tap to start or pause the fill timer (tap event)
  void toggleFill() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    } else {
      status = HeartStatus.filling;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        progress = _service.increase(progress); // increment progress
        await _service.savestate(progress, status);
        if (progress >= 1.0) {
          // when heart reaches the 100%
          progress = 1.0;
          status = HeartStatus.filled;
          _timer?.cancel();
          _isRunning = false;
          await _service.savestate(progress, status);
        }
        notifyListeners();
      });
      _isRunning = true;
    }
    notifyListeners();
  }

  // here clears the heart progress and resets state
  Future<void> clearHeart() async {
    _timer?.cancel();
    _isRunning = false;
    progress = 0.0;
    status = HeartStatus.empty;
    await _service.clearState();
    notifyListeners();
  }
}
