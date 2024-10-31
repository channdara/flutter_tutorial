import 'dart:async';
import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'timer_callback.dart';
import 'timer_state.dart';

TimerBloc? timerBloc;

class TimerBloc extends Cubit<TimerState> {
  TimerBloc() : super(TimerStateInit());

  int _timerValue = 0;
  Isolate? _isolate;
  bool _isRunning = false;
  final ReceivePort _receivePort = ReceivePort();

  bool get isRunning => _isRunning;

  void dispose() {
    _stopIsolate();
    close();
  }

  Future<void> startIsolate() async {
    _isRunning = true;
    _isolate = await Isolate.spawn(_timerIsolate, _receivePort.sendPort);
    _receivePort.listen((message) {
      if (message is int) {
        _timerValue = message;
        if (message == 0) {
          _isRunning = false;
          _stopIsolate();
          _doActionWhenTimerEnds();
        }
        emit(TimerStateTick(_timerValue));
      }
    });
  }

  void _stopIsolate() {
    if (_isolate != null) {
      _isolate?.kill(priority: Isolate.immediate);
      _isolate = null;
      _isRunning = false;
    }
  }

  static void _timerIsolate(SendPort sendPort) {
    int timerValue = 1000;
    sendPort.send(timerValue);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timerValue--;
      sendPort.send(timerValue);
    });
  }

  void _doActionWhenTimerEnds() {
    TimerCallback.onTimerEndedCallback?.call();
  }
}
