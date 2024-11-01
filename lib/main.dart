import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import 'src/screen/main_screen/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) await FlutterDisplayMode.setHighRefreshRate();
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  // @override
  // void initState() {
  //   timerBloc = TimerBloc();
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   timerBloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainScreen());
  }
}
