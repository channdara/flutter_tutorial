import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32.0),
      child: const SizedBox(
        height: 24.0,
        width: 24.0,
        child: CircularProgressIndicator.adaptive(strokeWidth: 3.0),
      ),
    );
  }
}
