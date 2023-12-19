import 'package:flutter/material.dart';

class PinCodeDialog extends ModalRoute<String> {
  PinCodeDialog({
    this.pinLength = 4,
    this.pinSpacing = 12.0,
  });

  final int pinLength;
  final double pinSpacing;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  String get barrierLabel => '';

  @override
  Color get barrierColor => Colors.black.withOpacity(0.90);

  @override
  bool get barrierDismissible => false;

  @override
  bool get opaque => false;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: _PinCodeDialogBody(
        pinLength: pinLength,
        pinSpacing: pinSpacing,
        callback: (code) => Navigator.of(context).pop(code),
      ),
    );
  }
}

class _PinCodeDialogBody extends StatefulWidget {
  const _PinCodeDialogBody({
    required this.pinLength,
    required this.pinSpacing,
    required this.callback,
  });

  final int pinLength;
  final double pinSpacing;
  final Function(String code) callback;

  @override
  State<_PinCodeDialogBody> createState() => _PinCodeDialogBodyState();
}

class _PinCodeDialogBodyState extends State<_PinCodeDialogBody> {
  final List<String> _pinCode = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ),
            Container(
              height: 100.0,
              width: 100.0,
              margin: const EdgeInsets.only(top: 64.0, bottom: 16.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: const Icon(
                Icons.lock_rounded,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            const Text(
              'Enter your PIN code',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Expanded(
              child: Align(
                child: Wrap(
                  spacing: widget.pinSpacing,
                  children: List.generate(
                    widget.pinLength,
                    _pinCodeIcon,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: ['1', '2', '3']
                    .map((element) => Expanded(
                          child: InkWell(
                            onTap: () => _addListItem(element),
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                element,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: Row(
                children: ['4', '5', '6']
                    .map((element) => Expanded(
                          child: InkWell(
                            onTap: () => _addListItem(element),
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                element,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: Row(
                children: ['7', '8', '9']
                    .map((element) => Expanded(
                          child: InkWell(
                            onTap: () => _addListItem(element),
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                element,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: Row(
                children: ['', '0', 'DEL']
                    .map((element) => Expanded(
                          child: InkWell(
                            onTap: element.isEmpty
                                ? null
                                : () {
                                    switch (element) {
                                      case '0':
                                        _addListItem(element);
                                        break;
                                      case 'DEL':
                                        _removeListItem();
                                        break;
                                    }
                                  },
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                element,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addListItem(String pin) {
    _pinCode.add(pin);
    setState(() {});
    if (_pinCode.length == widget.pinLength) {
      Future.delayed(const Duration(milliseconds: 100), () {
        widget.callback.call(_pinCode.join());
      });
    }
  }

  void _removeListItem() {
    if (_pinCode.isEmpty) return;
    _pinCode.removeLast();
    setState(() {});
  }

  String? _tryGetCode(int index) {
    try {
      return _pinCode[index];
    } catch (_) {
      return null;
    }
  }

  Widget _pinCodeIcon(int index) {
    return _tryGetCode(index) == null
        ? const Icon(Icons.circle, color: Colors.grey, size: 32.0)
        : const Icon(Icons.radio_button_on, color: Colors.blue, size: 32.0);
  }
}
