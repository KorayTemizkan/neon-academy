import 'package:firebase_messaging/firebase_messaging.dart';

/*
Bu fonksiyon ile arka planda da çalışma sağlanır.
İşletim sistemi uygulama kapalıyken bu fonksiyonu yine de çalıştırır


*/
@pragma('vm:entry-point')
Future<void> _firebaseCloudMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  print('arka planda mesaj geldi: ${message.messageId}');
}

class FirebaseCloudMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Kullanıcıdan izinler istenilir
    await _messaging.requestPermission();

    // Mevcut cihazın tokenini aldık (test için)
    // Sadece belirli kullanıcılara bildirim yollamak istiyorsak burada ayarlama yapabilirsin
    // Şu anda herkese gidiyor bildirimler
    String? token = await _messaging.getToken();
    print('TOKEN DEBUG: $token');

    // Arka plan dinleyicisini ayarla (Uygulama kapalıyken bildirim gelmesi)
    FirebaseMessaging.onBackgroundMessage(
      _firebaseCloudMessagingBackgroundHandler,
    );

    // Ön plan dinleyicisini ayarla
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
        'uygulama açıkken bildirim geldi brom: ${message.notification?.title}',
      );
      // Snackbar ya da showDialog ekleyebiliriz
    });

    // Bildirime tıklandığında uygulama açılırsa
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Bildirime tıklanıldı: Veri: ${message.data}');
      // Navigator ekleyebiliriz
    });
  }
}
