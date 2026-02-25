import 'package:flutter/material.dart';

class StackView extends StatelessWidget {
  const StackView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarını alıyoruz. Bunu daha önce kullandım ama yine de sor Koray.
    final mySize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hogwarts Spell Stack',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          // Buradaki width ve height ile responsive özellik sağladık. Aşağıda stack ve konumlandırma ile düzenli görünüm sağladık
          width: mySize.width * 0.8, // Yatayda ekranın %80'i kadar alan kapla
          height: mySize.height * 0.5, // Dikeyde ekranın %50'si kadar alan kapla
          color: Colors.grey,
          child: Stack(
            children: [
              // 1. Büyü: Sol Üst
              const Positioned(
                top: 20,
                left: 20,
                child: SpellLabel(text: "Expecto Patronum", color: Colors.cyan),
              ),

              // 2. Büyü: Sağ Üst
              const Positioned(
                top: 20,
                right: 20,
                child: SpellLabel(text: "Expelliarmus", color: Colors.red),
              ),

              // 3. Büyü: Sol Alt
              const Positioned(
                bottom: 20,
                left: 20,
                child: SpellLabel(text: "Stupefy", color: Colors.orange),
              ),

              // 4. Büyü: Sağ Alt
              const Positioned(
                bottom: 20,
                right: 20,
                child: SpellLabel(text: "Avada Kedavra", color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Normalde hep ayrı dosyada widget olarak kullanıyoruz bugünlük böyle deneyelim. Aynı mantık zaten.  
class SpellLabel extends StatelessWidget {
  final String text;
  final Color color;
  const SpellLabel({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
