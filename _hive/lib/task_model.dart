/*

Hive, Flutter ve Dart dünyasında aynı Shared Preferences gibi yerel veri saklama çözümleri sunan; hızlı, hafif ve NOSQL tabanlı bir anahtar-değer VERİTABANIDIR. 
SQLite gibi ilişkisel veritabanlarının aksine verileri diskte çok daha hızlı bir şekilde binary formatta saklar.
Saf dart kodu olduğu için platform bağımlı değil

Koray, Tığcık'ta da kullanıyoruz ama genel bir bilgilendirme bana da iyi gelir.


! BİLGİLENDİRME

* Hive'de veriler "box" adı verilen YAPILARDA tutulur. SQL tablosu ya da Windows klasörü gibi düşünebiliriz. Her box anahtar değer çiftlerini saklar
* Hive'de Shared Preferences'teki gibi temel veri türlerini barındırır, ayrıca kendi oluşturduğun modelleri kaydetmek istiyorsan bunu TypeAdapter ile yaparsın,
* her adapter'in benzersiz bir kimlik numarası olmalıdır, 0-223 arası


! ÇALIŞTIRMA SIRASI

-> Konsola:
Flutter pub add hive

-> Main içine
void main() async {
  await Hive.initFlutter(); // Hive paketini Flutter için hazırla
  await Hive.openBox('settings'); // "settings" adında bir kutu aç
  runApp(const MyApp());
}

-> Herhangi bir dosya içinde erişmek

? Kutu Açmak
var box = Hive.box('ayarlar');

? Veri Yazmak
box.put('theme', 'dark);

? Veri Okumak
String theme = box.get('theme', defaultValue: 'bright');

? Veri Silmek
box.delete('theme');


! Özel Model Açmak

import 'package:hive/hive.dart';

part 'urun_model.g.dart'; // build_runner ile oluşturulacak dosya

@HiveType(typeId: 1)
class Urun {
  @HiveField(0)
  final String ad;

  @HiveField(1)
  final double fiyat;

  Urun({required this.ad, required this.fiyat});
}

? bu kodu yazdıktan sonra konsola 'flutter pub run build_runner build' yazmak gerekiyor.
? .g.dart dosyası oluşacak. Daha sonra -> main içine Hive.registerAdapter(ProductAdapter());
? yazman gerekiyor


! Bölgesel yeniden çizdirme

ValueListenableBuilder(
  valueListenable: Hive.box('sepet').listenable(),
  builder: (context, box, child) {
    // Sadece bu blok içindekiler (örneğin aşağıdaki Row) yeniden çizilir.
    return Row(
      children: [
        child!, // Bu kısım (aşağıdaki Icon) ASLA yeniden çizilmez, sabit kalır.
        Text("Adet: ${box.length}"),
      ],
    );
  },
  child: Icon(Icons.shopping_cart), // Sabit duran, değişmeyen widget
)


! pubspec.yaml dosyası ayarlaması

dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^6.0.0
  build_runner: ^2.4.8
  hive_generator: ^2.0.1
  

*/

import 'package:hive/hive.dart';

part 'task_model.g.dart'; // Buildrunner bu dosyayı oluşturucak

@HiveType(typeId: 0) // Her alan için benzersiz bir index
// extennds HiveObject yaptık ki doğruca nesne üzerinde save ya da delete yapabilelim
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  List<String> colors;

  TaskModel({
    required this.title,
    required this.content,
    required this.colors,
  });
}
