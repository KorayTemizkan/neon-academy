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

    if (this % 2 != 0) {
      //3
      for (var i = 2; i < this; i++) {
        if (this % i == 0) {
          continue;
        }
        return 'Asal Değil';
      }
    }

    return '';
  }
}
