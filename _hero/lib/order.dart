class Order {
  // Singleton yaptık. Bu sınıfı Sadece bir kere oluşturmuş olduk
  static final Order _instance = Order._internal();
  factory Order() => _instance;
  Order._internal();

  final List<String> _myOrder = [
    'Up (Slide)',
    'Right (Zoom)',
    'Right (Zoom)',
    'Down (Cover)',
    'Left (Push)',
    'Up (Slide)',
    'Left (Push)',
  ];
  int _orderIndex = 0;

  List<String> get myOrder => _myOrder;
  int get orderIndex => _orderIndex;

  void increaseIndex() => _orderIndex++;
}
