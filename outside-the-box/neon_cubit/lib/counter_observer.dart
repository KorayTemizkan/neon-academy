/*
Uygulamadaki tüm durum değişimlerini merkezi bir noktadan izlemek için kullandığımız bir gözlem sayfası
Örneğin 20 farklı cubit olsaydı teker teker debug yapmak yerine buradan gözlemleyebilirsin
*/

import 'package:flutter_bloc/flutter_bloc.dart';

// flutter_bloc kütüphanesinin bize sunduğu özel bir sınıfı extends ile miras aldık
class CounterObserver extends BlocObserver {
  const CounterObserver();
  
  // Uygulamada herhangi bir Cubit ya da Bloc yeni bir durum yayınladığı (emit ettiği) anda otomatik tetiklenir
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

/*
BlocBase<dynamic> bloc: o an hangi Cubit çalıştıysa onun bilgilerini verir.
Change<dynamic> change: İçinde currentState ve nextState barındıran bir durumdur

super.onChange() ile fonksiyona devam et
print ile çıktıyı gör
*/