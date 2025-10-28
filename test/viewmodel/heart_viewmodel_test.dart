import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_async/fake_async.dart';
import 'package:heart_app/viewmodel/heart_viewmodel.dart';
//import 'package:heart_app/services/heart_service.dart';
import 'package:heart_app/model/heart_state.dart';
import 'heart_viewmodel_test.mocks.dart';

// unit tests for HeartViewModel
// here we use Mockito for mocking HeartService and FakeAsync for timer simulation
// and ensure that ViewModel logic, state updates, and also the resets should work as expected behaviour

void main() {
  late HeartViewModel vm;
  late MockHeartService mockService;

  setUp(() {
    mockService = MockHeartService();
    // Mock stored state for ViewModel initialization
    when(
      mockService.loadstate(),
    ).thenAnswer((_) async => {'progress': 0.0, 'status': HeartStatus.empty});
    when(
      mockService.increase(any),
    ).thenReturn(1.0); //// Mock behavior for increment and save/clear methods

    // Mock async save/clear calls
    when(mockService.savestate(any, any)).thenAnswer((_) async => {});
    when(mockService.clearState()).thenAnswer((_) async => {});

    vm = HeartViewModel(mockService);
  });

  // here basically verfies the inital state values after load
  test('ViewModel initializes correctly', () async {
    await Future.delayed(const Duration(milliseconds: 100));
    expect(vm.progress, equals(0.0));
    expect(vm.status, equals(HeartStatus.empty));
    expect(vm.isRunning, isFalse);
  });

  // here it will verifies the fill logic and reset using FakeAsync
  test('toggleFill updates progress and clearHeart resets', () {
    fakeAsync((async) {
      vm.toggleFill(); // starts filling
      async.elapse(const Duration(seconds: 10)); // simlates timer message
      expect(vm.progress, equals(1.0)); // filled
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
