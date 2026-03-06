import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

// ? Bir geliştiricinin uygulama mağazadayken güncelleme yapmadan uzaktan değişiklikler yapmasını sağlayan özelliktir.
/*

flutter pub add firebase_remote_config
Aşağıdaki fonksiyon yazılır
Firebase Console'de remote config etkinleştir
Ayarlamaları yap
Değişiklikleri yayınla butonuna bas

*/
class FirebaseRemoteConfigService extends ChangeNotifier {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  String get welcomeMessage => _remoteConfig.getString('welcome_message');
  String get imageUrl => _remoteConfig.getString('image_url');
  bool get isHidden => _remoteConfig.getBool('is_hidden');
  int get year => _remoteConfig.getInt('year');

  // Color çekmek biraz zor
  Color get backgroundColor {
    // 1. Firebase'den gelen stringi al (Örn: "#FFD1DC" veya "FFD1DC")
    String hexColor = _remoteConfig.getString('bg_color').replaceAll('#', '');

    // 2. Eğer başında FF yoksa (opaklık), biz ekleyelim
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    // 3. 16'lık tabanda sayıya çevir
    return Color(int.parse(hexColor, radix: 16));
  }

  Future<void> setupRemoteConfig() async {
    try {
      // Varsayılan değerler belirlenir
      await _remoteConfig.setDefaults(<String, dynamic>{
        'welcome_message': 'Eurovision Song Contest!',
        'bg_color': '#FFFFFF',
        'image_url': '',
        'is_hidden': false,
        'year': 20,
      });

      print('test1');

      // Ne kadar sık sürede güncelleme yapılır
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(
            minutes: 1,
          ), // 1 dakika boyunca denemeye devam et
          minimumFetchInterval: const Duration(
            minutes: 0,
          ), // 10 dakikada bir istek at (Test için 0 yaptım)
        ),
      );
      print('test2');

      // Verileri çek ve etkinleştir
      await _remoteConfig.fetchAndActivate();

      // Dinle ve ayar değişimi sonrası değiştir
      _remoteConfig.onConfigUpdated.listen((event) async {
        await _remoteConfig.activate();
        notifyListeners();
        print('test3');
      });
      print('test4');

      print(
        "Yeni isHidden değeri: ${_remoteConfig.getBool('is_hidden')}",
      ); // Bunu ekle
      notifyListeners();
    } catch (e) {
      print('Hata: $e');
    }
  }
}
