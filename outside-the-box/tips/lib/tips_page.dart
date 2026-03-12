import 'package:flutter/material.dart';
import 'package:tips/extensions.dart';
import 'package:tips/widgets/my_card_widget.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mesela başlıktaki TEXT widgetinin bir kere çizilmesi yeterli. Rebuild yaptırmamak için CONST ekle
      appBar: AppBar(
        title: const Text('TipsPage'),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          Text('test', style: context.textTheme.displayLarge),

          /*

          Zaten clean architecturede böyle yapmıyorum ama yine de not alayım,

          1) Widgetleri ayrı bir dart dosyasında sakla
          2) Her şeyi iç içe yapmak yerine metotlara böl

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('test'),
                ],
              ),
            ),
          ),
          */
          MyCardWidget(),
          Image(
            image: NetworkImage(
              'https://framerusercontent.com/images/DQv3U0KZp1tV0pVn1i2LQUDKkOM.png',
            ),
          ),
        ],
      ),
    );
  }
}
