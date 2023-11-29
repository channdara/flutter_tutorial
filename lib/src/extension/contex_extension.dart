import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void push(StatefulWidget screen) {
    final route = Platform.isAndroid
        ? MaterialPageRoute(builder: (_) => screen)
        : CupertinoPageRoute(builder: (_) => screen);
    Navigator.of(this).push(route);
  }
}
