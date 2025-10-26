import 'package:shared_preferences/shared_preferences.dart';
import '../model/heart_state.dart';

class HeartService {
  // here the filling will get increment inside the heart - HeartFill Service class

  // uses as a  Dependency Injection support for viewmodel

  double increase(double currentProgress) {
    double next = (currentProgress + 0.1);
    // to increase the filling by 10% for iteration
    next = double.parse(next.toStringAsFixed(1));
    return next.clamp(
      0.0,
      1.0,
    ); //return (currentProgress + 0.1).clamp(0.0, 1.0);
  }

  Future<void> savestate(double progress, HeartStatus status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('progress', progress);
    await prefs.setString('status', status.name);
  }

  Future<Map<String, dynamic>> loadstate() async {
    final prefs = await SharedPreferences.getInstance();
    double progress = prefs.getDouble('progress') ?? 0.0;
    String? statusStr = prefs.getString('status');
    HeartStatus status = HeartStatus.empty;
    if (statusStr != null) {
      status = HeartStatus.values.firstWhere(
        (e) => e.name == statusStr,
        orElse: () => HeartStatus.empty,
      );
    }
    return {'progress': progress, 'status': status};
  }

  Future<void> clearState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('progress');
    await prefs.remove('status');
  }
}
