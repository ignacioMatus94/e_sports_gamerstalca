// timer_service.dart
import 'dart:async';

class TimerService {
  final void Function() callback;
  Timer? _timer;

  TimerService(this.callback);

  void startTimer(void Function() updateProgress) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateProgress();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer(int seconds) {
    stopTimer();
    _timer = Timer(Duration(seconds: seconds), callback);
  }
}
