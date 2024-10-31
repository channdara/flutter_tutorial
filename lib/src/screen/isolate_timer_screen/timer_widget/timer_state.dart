abstract class TimerState {}

class TimerStateInit extends TimerState {}

class TimerStateTick extends TimerState {
  TimerStateTick(this.value);

  final int value;
}
