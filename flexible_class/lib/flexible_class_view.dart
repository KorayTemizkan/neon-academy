import 'package:flutter/material.dart';

class FlexibleClassView extends StatefulWidget {
  const FlexibleClassView({super.key});

  @override
  State<FlexibleClassView> createState() => _FlexibleClassViewState();
}

class _FlexibleClassViewState extends State<FlexibleClassView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FinSmart', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(8),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Ben hep Expanded kullandım ama bu Flexible de fena değilmiş
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.abc),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Welcome!'),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'How Are You Koray?',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(8),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          'https://blog.ofix.com/wp-content/uploads/2020/08/hesap_makinesi_kullanmanin_puf_noktalari_ofix_blog.jpg',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Hesap dökümü!'),
                    ),
                  ),

                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Dolar: 25',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Euro: 200000000000',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(8),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Beğen'),
                      ),
                    ),
                  ),

                  // Mesela ekran dikey olunca yap aşağı kayıyor, ama ekran yatay olunca yana kayıyor, neden çünkü flex sabit.
                  // Hep sola yatık olmaları seni kandırmasın, eğer metinler uzarsa ayarlamalar yapılıyor ama yine de 2/8'den büyük alan kaplamıyor
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Yorum Yap'),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Paylaş'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
