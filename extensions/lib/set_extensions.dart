extension SetExtensions on Set<String> {
  String uniques() {
    String myNewList = '';
    for (var element in this) {
      myNewList += element;
      myNewList += ' ';
    }

    return myNewList;
  }
}
