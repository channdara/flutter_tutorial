import 'package:flutter/material.dart';

import '../isolate_timer_screen/timer_widget/timer_widget.dart';
import 'pin_code_dialog.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String _status = 'Waiting';
  String _pinCode = '';

  void _openPinCodeDialog() {
    Navigator.of(context).push(PinCodeDialog()).then((code) {
      if (code == null) return;
      _pinCode = code;
      _status = code == '1684' ? 'PIN Correct' : 'Wrong PIN';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pin Code Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Example the correct pin code is: 1684'),
            const SizedBox(height: 8.0),
            Text('Pin received: $_pinCode'),
            const SizedBox(height: 8.0),
            Text('Status: $_status'),
            const SizedBox(height: 8.0),
            const TimerWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _openPinCodeDialog,
          child: const Text('Show Pin Code Dialog'),
        ),
      ),
    );
  }
}
