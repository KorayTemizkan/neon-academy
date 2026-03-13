import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart'; // Bu dosya build_runner sonrası oluşacak

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Ana Sayfa
    AutoRoute(page: HomeRoute.page, initial: true),
    // Detay sayfası
    AutoRoute(page: DetailRoute.page),
  ];
}

/*

?go_router paketinin en güçlü alternatifidir.

her sayfanın başına @RoutePage ekle ve bu sayfayı bir rotaya dönüştür
genel router sayfanı yukarıdaki gibi yaz. Merkez yönlendirmeyi ayarla.
"dart run build_runner build" kullanarak ise manuel yönlendirme zahmetinden kurtulduk
main dosyasına:

return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );

yaz


! Yeni bir sayfa eklediğinde ya da rotada değişiklik yaptığında build_runner'ı tekrar çalıştırmayı unutma
dart run build_runner watch --delete-conflicting-outputs -> bunu yazarsan senin yerine bu yapıyormuş tercih senin
*/