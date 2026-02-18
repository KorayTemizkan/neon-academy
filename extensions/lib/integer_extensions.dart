// Asal sayı mı?

// 2,3,5,7,11,13, 15!
extension IntegerExtensions on int {
  String isPrime() {
    if (this < 2) {
      return 'Asal Değil';
    }

    if (this == 2) {
      return 'Asal';
    }

    if (this % 2 == 0) {
      return 'Asal Değil';
    }

    for (var i = 3; i < this; i += 2) {
      if (this % i == 0) {
        return 'Asal Değil';
      }
    }

    return 'Asal';
  }
}
