import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'timer_bloc.dart';
import 'timer_state.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: timerBloc ??= TimerBloc(),
      buildWhen: (p, c) => c is TimerStateTick,
      builder: (context, state) {
        final int value = state is TimerStateTick ? state.value : 0;
        return Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
