class HeartService {
  // here the filling will get increment inside the heart - HeartFill Service class

  // uses as a  Dependency Injection support for viewmodel
  double increase(double currentProgress) {
    if (currentProgress < 1.0) {
      return (currentProgress + 0.1).clamp(0.0, 1.0);
    }
    return 1.0;
  }
}
