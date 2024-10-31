import 'dart:math';

import 'package:flutter/material.dart';

class RandomNumberScreen extends StatefulWidget {
  const RandomNumberScreen({super.key});

  @override
  State<RandomNumberScreen> createState() => _RandomNumberScreenState();
}

class _RandomNumberScreenState extends State<RandomNumberScreen> {
  final Random _random = Random();
  final String _notAvailable = 'N/A';
  final Map<int, int> _pickedNumber = {};
  int _randomizeNumber = 0;
  double _availableHeight = 0.0;

  String _getHighestPickedNumber() {
    if (_pickedNumber.isEmpty) return _notAvailable;
    final highestEntry = _pickedNumber.entries
        .reduce((current, next) => current.value > next.value ? current : next);
    return highestEntry.key.toString();
  }

  String _getRandomizeNumber() {
    return _randomizeNumber < 1 ? _notAvailable : _randomizeNumber.toString();
  }

  double _getVerticalBarHeight(int value) {
    final minValue = _pickedNumber.values.reduce(min);
    final maxValue = _pickedNumber.values.reduce(max);
    final scalingFactor = _availableHeight / max(1, maxValue - minValue);
    print('$value = ${max(1, value - minValue) * scalingFactor}');
    return max(1, value - minValue) * scalingFactor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Highest Picked: ${_getHighestPickedNumber()}'),
        actions: [
          IconButton(
            onPressed: () {
              _pickedNumber.clear();
              _randomizeNumber = 0;
              setState(() {});
            },
            icon: const Icon(Icons.lock_reset_rounded),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          _availableHeight = constraints.maxHeight - 16.0;
          return ListView.builder(
            padding: const EdgeInsets.only(left: 4.0),
            scrollDirection: Axis.horizontal,
            itemCount: _pickedNumber.keys.length,
            itemBuilder: (context, index) {
              final key = _pickedNumber.keys.toList()[index];
              final value = _pickedNumber[key]!;
              return Container(
                height: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.red,
                      height: _getVerticalBarHeight(value),
                      width: 10.0,
                      margin: const EdgeInsets.only(right: 4.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Text(key.toString()),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Randomized Number: ${_getRandomizeNumber()}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16.0),
            ElevatedButton(
              onPressed: () {
                _randomizeNumber = _random.nextInt(20) + 1;
                _pickedNumber.update(
                  _randomizeNumber,
                  (value) => value + 1,
                  ifAbsent: () => 1,
                );
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Randomize'),
            ),
          ],
        ),
      ),
    );
  }
}
