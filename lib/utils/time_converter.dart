class TimeConverter {
  static String intToTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursString = hours < 10 ? "0$hours" : "$hours";
    String minutesString = minutes < 10 ? "0$minutes" : "$minutes";
    String secondsString =
        remainingSeconds < 10 ? "0$remainingSeconds" : "$remainingSeconds";

    return "$hoursString:$minutesString:$secondsString";
  }
}
