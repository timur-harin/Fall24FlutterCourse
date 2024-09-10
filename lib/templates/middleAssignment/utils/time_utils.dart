String formatTotalTime(Duration totalTime) {
  final minutes = totalTime.inMinutes;
  final seconds = totalTime.inSeconds - minutes * 60;

  if (minutes > 0 && seconds > 0) {
    return 'Total time: $minutes minutes, $seconds seconds';
  } else if (minutes > 0) {
    return 'Total time: $minutes minutes';
  } else if (seconds > 0) {
    return 'Total time: $seconds seconds';
  } else {
    return 'Total time: 0 seconds';
  }
}
