typedef OnTimerEndedCallback = void Function();

mixin TimerCallback {
  static OnTimerEndedCallback? onTimerEndedCallback;
}
