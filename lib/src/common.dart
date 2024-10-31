import 'package:flutter/foundation.dart';

void logDebug(List<dynamic> contents) {
  if (kDebugMode) print('LOG_DEBUG 👉 ${contents.join(' | ')}');
}
