extension BooleanExtensions on bool {
  String isThereKLetter() {
    if (this == true) {
      return 'K harfi var';
    } else {
      return 'K harfi Yok';
    }
  }
}
