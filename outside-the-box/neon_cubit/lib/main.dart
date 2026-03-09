import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_counter/app.dart';
import 'package:flutter_counter/counter_observer.dart';

void main() {
  // Sisteme observerimizi tanımladık
  Bloc.observer = const CounterObserver();
  runApp(const CounterApp());
}

/*
! MADEM ÖĞRENİYORUM TAM ÖĞRENEYİM
VSCode: Microsoft tarafından geliştirilen, dünyada en yaygın kullanılan ücretsiz ve açık kaynaklı bir kod düzenleyicisidir (code editor)
Yani sadece metin yazma yeri değil, tüm projenin yönetildiği bir merkezdir
Biz Flutter SDK ile derleyiciyi bilgisayar koyduk, VSCode editöründe Flutter ve Dart eklentilerini kurduk ve VSCode <-> Derleyici bağlantısını tanımladık
Örneğin Android Studio ise baştan sona her şey dahili




! BAĞIMLILIK SIRASI
* void main() -> runApp() -> CounterApp() -> CounterPage() -> CounterCubit()
*                                                           -> CounterView()
* counterObserver()




! Dosya Yapısı

counter_app.dart: MaterialApp'li kök widget

counter_page.dart: Bağımlılıkların (Cubit) sağlandığı yer.

counter_cubit.dart: İş mantığı (Business Logic).

counter_view.dart: Tasarımın olduğu yer.


counter_observer: Küresel durum izleme merkezi
counter.dart (Barrel): Hepsini paketleyip sunan kapı.




! Diğer Dosyalar

* Yapılandırma ve Bağımlılık Katmanları (En üst düzey)
.dart_tool: Dart'ın pubspec_yaml'daki paketleri işlediği yer. Derleme araçları buradadır. Dışarıdan müdahaele edilemez
.idea: Kullanılan editör
android: Bunlar platform klasörleridir. Yazılan Dart kodunun bu cihazlarda çalışabilmesi için gereken yerel (native) dosyaları tutar

* Kaynak Kod Katmanı (Yazılan Kodlar)
lib: Yazılan tüm .dart dosyalarının bulunduğu yerdir

* Tanımlama ve Ayar Dosyaları (Projenin Kimliği)
assets: Resim, font, json dosyaları gibi ögeler buradadır.
.flutter-plugins: Projede kullandığımız paketlerin (örneğin flutter_bloc) bilgisayarındaki tam konumlarını (path) tutar.
.gitignore: Github'a yüklenmeyecek dosyaları ayarlar
.metadata: Projenin hangi flutter sürümüyle ve hangi channel (stable, beta vb.) üzerinde oluşturulduğunu tutar. Flutter SDK bu dosyaya bakarak projenin kendisiyle uyumlu olup olmadığını anlar. Elle dokunulmaz.
anaylsis_options.yaml: Kod yazarken Flutter'ın kod uyarıları vermesini sağladığı yerdir
pubspec.yaml: Projenin beynidir. Uygulama adı, sürümü, hangi paketlerin kullanıldığını vs. burada tanımlanır
pubspec.loc: pubspec.yaml'da belirttiğin paketlerin hangi tam sürümle yüklendiğini kaydeder




! Kod yazma süreci gibi düşün
*pubspec.yaml üzerinden paketleri istersin.
*.dart_tool bu paketleri indirir ve projeye bağlar.
*Sen lib/ içinde kodunu yazarsın.
*android/ios/ klasörleri bu kodu paketleyip telefona gönderir.
*Hata yaparsan analysis_options.yaml seni uyarır.
*/