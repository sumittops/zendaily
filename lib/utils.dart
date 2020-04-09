
String toTwoDigits(int n) {
  if (n >= 10) {
    return '$n';
  }
  return '0$n';
}

String getDurationInHMS(Duration duration) {
  return '${toTwoDigits(duration.inHours)}:${toTwoDigits(duration.inMinutes.remainder(60))}:${toTwoDigits(duration.inSeconds.remainder(60))}';
} 