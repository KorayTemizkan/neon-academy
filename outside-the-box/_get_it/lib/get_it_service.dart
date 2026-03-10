import 'package:_get_it/user_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // sl -> service locator

Future<void> setupLocator() async {
  // UserService sınıfını bir kez oluştur ve depoya koy (Singleton)
  sl.registerLazySingleton<UserService>(() => UserService());
}

/*

MAİN:
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  
GetIt bir dependency injenction yöntemidir
Özet olarak buraya bir beyin diyebiliriz.
Veriyi eskiden sınıflar aracılığıyla parametre vererek taşırdık.
Artık gerek yok, tek bir kere tanımlayarak her yerden erişebiliyoruz

GEMİNİ ÖZETİ:

Gemini şunu dedi:

GetIt, uygulamanın herhangi bir yerinden ihtiyaç duyduğun servis veya nesnelere,
onları elden taşımak zorunda kalmadan merkezi bir "lojistik deposundan" tek satırla ulaşmanı sağlayan bir araçtır.


Provider ile GetIt birbirine benzer duruyor. Ama Provider widget ağacına bağımlıdır, GetIt tamamen bağımsız bir dart nesnesidir.
*/