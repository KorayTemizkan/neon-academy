import 'package:comedy_club_challenge/show_model.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final ShowModel model;
  const DetailView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pinkAccent,
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // Yüksekliği içeriğe göre belirlemesi için Flexible'ları siliyoruz
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.pinkAccent, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // İçeriği kadar yer kaplasın
                children: [
                  SizedBox(
                    // Flexible yerine doğrudan SizedBox veya Image
                    height:
                        250, // Detay sayfası olduğu için biraz daha büyük yapabilirsin
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(14),
                      ),
                      child: Image.network(model.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      model.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    model.category,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16), // Alt kısımda biraz boşluk
                ],
              ),
            ),
          ),

          Card(
            color: Colors.pinkAccent,
            elevation: 1,
            margin: const EdgeInsets.all(8),
            child: Text(
              textAlign: TextAlign.center,
              'Eğlenceye Hazır Mısın?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
