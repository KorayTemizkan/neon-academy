// Palindrom sözcük mü?

extension StringExtensions on String {
  String toCapitalize() {
    if (this.isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }

  String isPallindrom() {
    if (this.isEmpty) {
      return 'Sözcük girmediniz';
    }

    if (this.length == 1) {
      return 'Palindrom';
    }

    // aba
    if (this.length % 2 != 0) {
      for (int start = 0, length = this.length - 1; start != length;) {
        // aba
        if (this[start] == this[length]) {
          //1 1
          start++;
          length--;
          if (start == length) {
            return 'Palindrom';
          }
          continue;
        } else {
          return 'Palindrom Değil';
        }
      }
    }

    //abba
    if (this.length % 2 == 0) {
      for (int start = 0, length = this.length - 1; start != length;) {
        if (this[start] == this[length]) {
          //0 3
          //1 2
          //2 1
          start++;
          length--;
          if (start > length) {
            return 'Palindrom';
          }
          continue;
        } else {
          return 'Palindrom Değil';
        }
      }
    }

    return '';
  }
}
