import 'package:flutter/material.dart';
import 'package:flutter_tutorial/src/screen/main_screen/main_screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
