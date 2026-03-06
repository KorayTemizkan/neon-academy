import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/counter/counter.dart';

// İş mantığı (Cubit) ile UI'nın birbirine bağlandığı yer
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    /* BlocProvider, bir cubiti widget ağacına yerleştirir
    (_) -> normalde (BuildContext context) olması gerek ama bizim contexte ihtiyacımız olmadığı için böyle yapıyoruz
    => tek satırlık fonksiyonlarda bu kullanılır
    varsayılan olarak create, verilen isteğe ihtiyaç duyulana kadar onu oluşturmaz
    
    BlocProvider CounterCubit'i bir kez oluşturur ve otomatik dispose yapar
    */
    return BlocProvider(create: (_) => CounterCubit(),
    child: const CounterView(),
    );
  }
}