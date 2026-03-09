import 'package:clean_architecture/config/theme/app_themes.dart';
import 'package:clean_architecture/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:flutter/material.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: const DailyNews(),
    );
  }
}

/*

! EN TEMEL ÖZET 

Clean Architecture (Temiz Mimari), uygulamanı bir soğan gibi katmanlara ayırır. Temel kural şudur: **İç katmanlar dış katmanlar hakkında hiçbir şey bilmez.** Bu sayede,
örneğin veri tabanını (DB) değiştirdiğinde arayüzün (UI) bundan haberi bile olmaz.

API/DB/vb. -> DATA -> DOMAİN -> PRESENTATİON
---

? 1. Data (Veri) Katmanı: Dış Dünya

Burası verinin "ham" haliyle uğraşıldığı, en kirli işlerin yapıldığı yerdir.

* **Raw Data & Sources:** Verinin geldiği kaynaklardır. Bir API (Bulut), bir DB (Cihaz hafızası) veya konum bilgisi olabilir.
* **Remote & Local Data Sources:** İnternetten veya yerel depodan veriyi çeken sınıflardır.
* **Models:** API'den gelen karmaşık JSON verisini Dart nesnelerine dönüştürür. Models klasörü sadece bu katmana özeldir.
* **Repositories (Implementation):** Domain katmanındaki şablonu kullanarak veriyi gerçekten çeken ve işleyen kısımdır.

? 2. Domain (Alan) Katmanı: Uygulamanın Kalbi

Bu katman **bağımsızdır.** Flutter SDK veya herhangi bir paket içermez. Sadece saf mantıktır.

* **Entities:** Uygulamanın temel taşlarıdır. Örneğin bir "User" veya "Counter" nesnesi.
* **Repositories (Abstract):** Verinin *nasıl* alınacağını değil, *ne* alınacağını belirleyen bir sözleşmedir (Arayüz).
* **Use Cases:** Uygulamanın özellikleridir. "Kullanıcı giriş yapsın", "Sayıyı artır" gibi her bir iş mantığı tek bir Use Case dosyasıdır.

? 3. Presentation (Sunum) Katmanı: Kullanıcıyla Temas

Kullanıcının gördüğü ve etkileşime girdiği katmandır.

* **Presentation Logic Holders:** Senin kullandığın **Cubit**, Bloc veya ChangeNotifier buradadır. Use Case'den gelen veriyi alır ve UI'ın anlayacağı hale getirir.
* **Widgets:** İlk görseldeki o meşhur **Widget Ağacı** buradadır. `Scaffold`, `AppBar`, `Text` gibi sadece görseli temsil eden bileşenler.

---

? Akış Nasıl İşler? (Call Flow)

Görseldeki sağ tarafta bulunan ok (Call Flow) yönüne bakarsan:

1. **Widget** (Butona basılır) -> **Cubit**'e haber verir.
2. **Cubit** -> İlgili **Use Case**'i çalıştırır.
3. **Use Case** -> **Repository**'den veri ister.
4. **Repository** -> Veri kaynağından (API/DB) veriyi alır ve **Entity** olarak geri döndürür.
5. **Cubit** -> Gelen veriyi (State) **Widget**'a yansıtır ve ekran güncellenir.

*/
