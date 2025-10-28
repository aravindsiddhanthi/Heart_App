import 'package:shared_preferences/shared_preferences.dart';
import '../model/heart_state.dart';

//Service layer – handles heart filling logic and state persistence
// supports  as a  Dependency Injection support for viewmodel

class HeartService {
  double increase(double currentProgress) {
    double next =
        (currentProgress +
        0.1); // increase the filling by 10% for every iteration
    next = double.parse(next.toStringAsFixed(1)); // rounds to one decimal
    return next.clamp(
      //
      0.0,
      1.0,
    );
    //return (currentProgress + 0.1).clamp(0.0, 1.0);
  }

  // Saves progress and status using SharedPreferences
  Future<void> savestate(double progress, HeartStatus status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('progress', progress);
    await prefs.setString('status', status.name);
  }

  Future<Map<String, dynamic>> loadstate() async {
    // here looads the  previously saved progress and also the  status
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
    // Clears stored heart state data
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('progress');
    await prefs.remove('status');
  }
}
