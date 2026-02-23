import 'package:flutter/material.dart';

class StackView extends StatefulWidget {
  const StackView({super.key});

  @override
  State<StackView> createState() => _StackViewState();
}

class _StackViewState extends State<StackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 48),
          
          // Ekran dikeyken sola yatık şekilde dikey sıralanırlar.
          // Ekran yatayken sola yatık şekilde dikey sıralanırlar
          // Aralarındaki boşluğu otomatik ayarlarlar çünkü Expanded widgeti responsive tasarım yapmamızı sağlar.
          Expanded(child: Text('Expelliarmus')),
          Expanded(child: Text('Expecto Patronum')),
          Expanded(child: Text('Stupefy')),
          Expanded(child: Text('Lumos')),
        ],
      ),
    );
  }
}
