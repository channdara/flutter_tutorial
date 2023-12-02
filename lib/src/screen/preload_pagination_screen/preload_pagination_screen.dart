import 'package:flutter/material.dart';

class PreloadPaginationScreen extends StatefulWidget {
  const PreloadPaginationScreen({super.key});

  @override
  State<PreloadPaginationScreen> createState() =>
      _PreloadPaginationScreenState();
}

class _PreloadPaginationScreenState extends State<PreloadPaginationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre-Load Pagination ListView')),
    );
  }
}
