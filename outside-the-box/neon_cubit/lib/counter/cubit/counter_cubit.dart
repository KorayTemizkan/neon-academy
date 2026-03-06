/*
! İş mantığı kısmı burasıdır

Cubit<int> ile bu Cubit'in içeride hangi türde bir veri saklayacağını belirleriz

super(0) ile başlangıçta bu Cubit'in state değişkeninin ilk değeri 0 atandı

emit'i notifyListeners()'in daha gelişmişi olarak düşünebilirsin
emit yeni bir durum yayınlar
sadece o veriyi dinleyen (mesela BlocBuilder) widgetleri günceller

? Fark ettiysen hiçbir Flutter kodu yok, iş mantığını ui'den tamamen ayırarak clean architecture'ye adım attık
*/

import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
