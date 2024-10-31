import 'package:flutter/material.dart';

import '../../extension/contex_extension.dart';
import '../pin_code_screen/pin_code_screen.dart';
import 'timer_widget/timer_widget.dart';

class IsolateTimerScreen extends StatefulWidget {
  const IsolateTimerScreen({super.key});

  @override
  State<IsolateTimerScreen> createState() => _IsolateTimerScreenState();
}

class _IsolateTimerScreenState extends State<IsolateTimerScreen> {
  // int _timerValue = 0;
  // Isolate? _isolate;
  // bool _isRunning = false;
  // final ReceivePort _receivePort = ReceivePort();
  //
  // @override
  // void initState() {
  //   SchedulerBinding.instance.addPostFrameCallback((callback) {
  //     _startIsolate();
  //   });
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _stopIsolate();
  //   super.dispose();
  // }
  //
  // Future<void> _startIsolate() async {
  //   _isRunning = true;
  //   _isolate = await Isolate.spawn(_timerIsolate, _receivePort.sendPort);
  //   _receivePort.listen((message) {
  //     if (message is int) {
  //       _timerValue = message;
  //       if (message == 0) {
  //         _isRunning = false;
  //         _stopIsolate();
  //         _doActionWhenTimerEnds();
  //       }
  //       setState(() {});
  //     }
  //   });
  // }
  //
  // void _stopIsolate() {
  //   if (_isolate != null) {
  //     _isolate?.kill(priority: Isolate.immediate);
  //     _isolate = null;
  //     _isRunning = false;
  //   }
  // }
  //
  // static void _timerIsolate(SendPort sendPort) {
  //   int timerValue = 100;
  //   sendPort.send(timerValue);
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     timerValue--;
  //     logDebug(['Timer', timerValue]);
  //     sendPort.send(timerValue);
  //   });
  // }
  //
  // void _doActionWhenTimerEnds() {
  //   logDebug(['Timer reached zero! Performing an action...']);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate Timer Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TimerWidget(),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                context.push(const PinCodeScreen());
              },
              child: const Text('Open Pin Code Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
