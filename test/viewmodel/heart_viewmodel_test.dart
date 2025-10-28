import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_async/fake_async.dart';
import 'package:heart_app/viewmodel/heart_viewmodel.dart';
//import 'package:heart_app/services/heart_service.dart';
import 'package:heart_app/model/heart_state.dart';
import 'heart_viewmodel_test.mocks.dart';

void main() {
  late HeartViewModel vm;
  late MockHeartService mockService;

  setUp(() {
    mockService = MockHeartService();

    // Mock loadstate() for ViewModel initialization
    when(
      mockService.loadstate(),
    ).thenAnswer((_) async => {'progress': 0.0, 'status': HeartStatus.empty});

    // Mock increase() to increment instantly
    when(mockService.increase(any)).thenReturn(1.0);

    // Mock async save/clear calls
    when(mockService.savestate(any, any)).thenAnswer((_) async => {});
    when(mockService.clearState()).thenAnswer((_) async => {});

    vm = HeartViewModel(mockService);
  });

  // ✅ 1️⃣ Initialization Test
  test('ViewModel initializes correctly', () async {
    await Future.delayed(const Duration(milliseconds: 100));
    expect(vm.progress, equals(0.0));
    expect(vm.status, equals(HeartStatus.empty));
    expect(vm.isRunning, isFalse);
  });

  // ✅ 2️⃣ Toggle and Clear using FakeAsync
  test('toggleFill updates progress and clearHeart resets', () {
    fakeAsync((async) {
      // Start filling
      vm.toggleFill();

      // Simulate passage of time for the timer (10 seconds virtual)
      async.elapse(const Duration(seconds: 10));

      // Now verify fill completed
      expect(vm.progress, equals(1.0));
      expect(vm.status, equals(HeartStatus.filled));
      expect(vm.isRunning, isFalse);

      // Clear and verify reset
      vm.clearHeart();
      expect(vm.progress, equals(0.0));
      expect(vm.status, equals(HeartStatus.empty));
      expect(vm.isRunning, isFalse);
    });
  });
}
