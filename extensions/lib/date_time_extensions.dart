extension DateTimeExtensions on DateTime {
  int calculateRemainingDays(DateTime second) {
    Duration difference = this.difference(second);

    return difference.inDays.abs();
  }
}
