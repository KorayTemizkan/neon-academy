// Flutter'ın temel tasarım dili olan Material Design bileşenlerini (Text, Padding vb.) kullanabilmek için bu kütüphaneyi ekle.
import 'package:flutter/material.dart';

/*
Stateless widget olması yeniden çizilebilme özelliğini değiştirmiyor. Kendi
içinde yeniden çizilmiyor, dışarıdan talimat gelirse çiziliyor. ListViewBuilder düşünelim. yeni öge eklenirse tüm listeyi yeniden çizecek tabii ki.
ama bu bir üst katmanının sorunu
*/

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({super.key});
  // Buradaki const bu widgetin hafızada tutulacağını ve yeniden çizilmeyeceğini ayarlar
  // super.key Flutter'ın bu özel widgeti tanımasını sağlar
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: _buildCardContent(),
    );
  }

  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text('card_test'),
        ],
      ),
    );
  }
}
