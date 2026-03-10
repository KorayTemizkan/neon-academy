import 'package:clean_architecture/config/theme/app_themes.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:clean_architecture/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // İlk başta bunu eklemediğimiz için siyah ekran geliyordu ve uygulama hiç başlatılamıyordu
  // Bunun sayesinde Flutter motoru ile telefon donanımı arasında köprü kurulur
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(theme: theme(), home: const DailyNews()));
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

! DAHA FAZLA AÇIKLAMA

EN ALTTAN EN ÜSTE DOĞRU SIRASIYLA AÇIKLAYARAK GİDELİM
clean_architecture/lib/features/daily_news -> bu konumdayız şu an

YEREL/UZAK KATMAN

API: https://newsapi.org/v2/top-headlines?apiKey=ff957763c54c44d8b00e5e082bc76cb0&country=us&category=business

VERİ KATMANI -> Dış dünya ile iletişim kurulan yerdir

 DATA SOURCE:
(/data/datasources/remote/news_api_service.dart) dosyasında Dio paketiyle apiye istek atılır, gelen ham JSON verisi ArticleModel listesine dönüştürülür
MODEL:
Veri modeli burada bulunur. ArticleEntity(iş mantığı katmanı)’den miras alır
REPOSITORY(Implementation olan):
news_api_service.dart kullanarak veriyi çeken yer burasıdır. Cevabın başarılı ya da başarısız olma durumuna göre DataSuccess ya da DataFailed sınıfları ile sarmalayıp bir üst katmana sunar

İŞ MANTIĞI KATMANI -> Uygulamanın beynidir; ne API’yi ne de UI’ı tanır

REPOSITORY(Interface):
Veri katmanındaki repositorynin ne yapması gerektiğini söyleyen bir sözleşme “abstract class” dosyasıdır
ENTITIES:
Veri katmanındaki modelin iş mantığı katmanındaki hali.
USE CASE:
Uygulamanın yaptığı belirli bir işi temsil eder. Örneğin GetArticleUseCase ile sadece haberleri getir görevini yerine getiririz. Bloc doğrudan repository’yi değil bu UseCase’yi çağırır

SUNUM KATMANI
STATE MANAGEMENT:
Durum yönetimi sistemi kurulur. Haberleri yükle gibi olayları alır, UseCase’yi çalıştırırır, ekrana “yükleniyor”, “tamamlandı” ya da “hata” gibi durumları gönderir.
WIDGETS:
Tekrar kullanılabilir arayüz araçları tanımlanır
PAGES:
Sayfalar tanımlanır

TÜM AKIŞ

Kullanıcı Sayfayı Açar → UI (DailyNews) → Bloc (Event) → UseCase → Repository (Interface) → Repository (Implementation) → NewsApiService (Dio) → News API (Remote) → Ham JSON Verisi <EN TEMEL NOKTA> ArticleModel (fromJson) → ArticleEntity → DataSuccess (Sarmalayıcı) → Repository (Implementation) → UseCase → Bloc (State) → UI (ListView/ArticleWidget)

*/
