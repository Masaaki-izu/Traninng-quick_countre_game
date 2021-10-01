import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import '../etc/cs.dart';

final timerProvider = StateNotifierProvider.autoDispose<TimerNotifier>(
      (ref) => TimerNotifier(),
);

final _timeLeftProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(timerProvider.state).timeLeft;
});

final _timerStateProvider = Provider.autoDispose<TimerState>((ref) {
  return ref.watch(timerProvider.state).timerState;
});

final timeLeftProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(_timeLeftProvider);
});

final timerStateProvider = Provider.autoDispose<TimerState>((ref) {
  return ref.watch(_timerStateProvider);
});

class TimerNotifier extends StateNotifier<TimerModel> {
 TimerNotifier() : super(_initialState);
  static const int _initialDuration = 0;
  static const int _initialDurationMax = counterMax;
  static final _initialState = TimerModel(
    _durationString(_initialDuration),
    TimerState.initial,
  );

  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  static String _durationString(int duration) {
    int hundreds = (duration / 10).truncate();
    int seconds = (hundreds / 100).truncate();

    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    String secondsStr = (seconds).toString().padLeft(2, '0');
    return    '$secondsStr.$hundredsStr';
  }

  void start() {
    if (state.timerState == TimerState.paused) {
      _restartTimer();
    } else {
      _startTimer();
    }
  }

  void _restartTimer() {
    _tickerSubscription?.resume();
    state = TimerModel(state.timeLeft, TimerState.started);
  }

  void _startTimer() {
    _tickerSubscription?.cancel();

    _tickerSubscription =
        _ticker.tick(ticks: _initialDurationMax).listen((duration) {
        state = TimerModel(_durationString(duration), TimerState.started);
    });

    _tickerSubscription?.onDone(() {
      state = TimerModel(state.timeLeft, TimerState.finished);
      return; //
    });
    
    state = TimerModel(_durationString(_initialDuration), TimerState.started);
  }

  void pause() {
    _tickerSubscription?.pause();
    state = TimerModel(state.timeLeft, TimerState.paused);
  }

  void reset() {
    _tickerSubscription?.cancel();
    state = _initialState;
  }

  void stop() {
    _tickerSubscription?.cancel();
    state = TimerModel(state.timeLeft, TimerState.finished);//_initialState;
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

class Ticker {
  Stream<int> tick({int? ticks}) {
    return Stream.periodic(
      Duration(milliseconds: 1),
          (x) => x + 1,
    ).take(ticks!);
  }
}

class TimerModel {
  const TimerModel(this.timeLeft, this.timerState);
  final String timeLeft;
  final TimerState timerState;
}

enum TimerState {
  initial,
  started,
  paused,
  finished,
}
