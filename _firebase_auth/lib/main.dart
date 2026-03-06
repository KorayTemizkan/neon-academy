/*

Doğruca google linkiyle giriş yapmayı ve bildirim önceliklemeyi(renkli olmak(sanırım channel olayı)) yapmadım. Bunlar dışında her şey yapılı
Tüm Firebase fonksiyonlarını tek dosyada yaptım ki daha rahat göreyim. Tek dosyayı bütün görevlere yüklüyorum

Ben daha önce Firebase auth ve storage kullanmıştım ama daha sonra Supabase'ye geçtim. 

? Firebase projesi başlatma adımları

1) WEB: Firebase Console üzerinden proje aç
2) BİLGİSAYAR: Nodejs kur -> npm install -g firebase-tools -> firebase login -> dart pub global activate flutterfire_cli
3) KÖPRÜ: Proje dosyasında terminale flutterfire configure
4) PROJE: flutter pub add firebase_auth

*/

import 'package:_firebase_auth/controllers/firebase_cloud_messaging_service.dart';
import 'package:_firebase_auth/controllers/firebase_remote_config_service.dart';
import 'package:_firebase_auth/controllers/firebase_service.dart';
import 'package:_firebase_auth/views/auth/login_view.dart';
import 'package:_firebase_auth/views/auth/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bulutla bağlantı sağlanır, DefaultFirebaseOptions ile mevcut os anlaşılır
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ! Firebase Crashlytics
  /*
  Tüm Flutter hizmetlerinde yaşanacak sorunları kontrollü bir şekilde görmeni sağlar.
  Uygulama çökerken diske hata dosyası kaydediler. Bir sonraki açılışta Firebase'e gönderilir

  flutter pub add firebase_crashlytics
  aşağıdaki fonksiyonlar eklenir
  Firebase Console'de crashlytics etkinleştirilir

  */
  // Flutter tarafından yakalanan tüm hataları Crashlytics'e gönder
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Uygulama içinde async hataları gibi yakalanamayan hataları da Crashlytics'e gönder
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // !

  // ! Firebase Auth
  // Uygulama açık olduğu sürece arka planda çalışacak bir dinleyici
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is currently signed in!');
    }
  });
  // !

  // ! Firebase Remote Config
  // .. ile getAllItems'taki gibi de yapabilirsin ama bu pek iyi bir yöntem değil çünkü yeniden çizim gerekiyor filan
  final configService = FirebaseRemoteConfigService();
  await configService.setupRemoteConfig();
  // !

  // ! Firebase Cloud Messaging
  /*
  flutter pub add firebase_messaging
  flutter pub add firebase_in_app_messaging
  aşağıdaki fonksiyonlar eklenir
  android manifest dosyasına intent-filter eklenir
  firebase_cloud_messaging_service.dart dosyasında katman oluşturulup fonksiyonlar yazılır
  fcm token alınır ve firebase sitesinde kaydedilir
  */
  final fcmService = FirebaseCloudMessagingService();
  await fcmService.initNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseService>(
          // ! Firebase Storage ve Firestore
          create: (_) => FirebaseService()..getAllItems(),
          // !
        ),
        ChangeNotifierProvider.value(value: configService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        // x durumunda değişiklik olunca akış başlat gibi düşünebilirsin
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Loading...');
          }
          if (!snapshot.hasData) {
            // Eğer veri yoksa kayıt ekranı
            return const RegisterView();
          }

          // Eğer veri varsa giriş yap ekranı
          final user = snapshot.data!;
          return LoginView();
        },
      ),
    );
  }
}
