/*

Flutter'da iki farklı dil konuşan widget grubu vardır. Box ve Sliver

Box Dünyasında container, card, text gibi widgetler vardır. Bunlar sabit ölçülerle konuşur
Sliver Dünyasında SliverList, SliverGrid gibi widgetler vardır. Bunlar sadece kaydırılabilir
anlarlarda yaşarlar ve ekranın neresindeyim, ne kadarım görünüyor hesabı yaparlar.

CustomScrollView içine doğrudan text koyunca çökmesinin sebebi budur. Bu sadece sliver elemanlar alır
İlle de kullanmak istiyorsan SliverToBoxAdapter kullanırsın

Bir sayfada hem liste hem grid varsa SLiverList ve SliverGrid beraber hareket eder. ListView 2 tane varsa ikisi
kendi aralarında bağımsız kaydırılabilirler.

3. Esneklik ve Performans

    ListView: Hızlıca bir liste yapmak için harikadır.
    ListView.builder kullanarak binlerce elemanı performanslıca gösterebilirsin.
    Ama "listem bitsin sonra yan yana kutular (grid) gelsin ve hepsi beraber kaysın"
    dersen çaresiz kalır (shrinkWrap kullanman gerekir ki bu da performansı düşürür).

    SliverList: "Karmaşık Tasarımların" kahramanıdır.
    Listenin arasına reklamlar, farklı ızgaralar veya kaydırdıkça küçülen başlıklar
    koyacaksan tek seçenek budur. Performansı her zaman zirvededir çünkü sadece ekrandaki kısmı hesaplar.

Basit sayfalar için: ListView + shrinkWrap OK.
Verinin çok olduğu sayfalar için: Kesinlikle Sliver (CustomScrollView).

BU KONUYA SONRA YİNE DÖN BAK KORAY KENDİ YÖNTEMİMİZ SANIRIM KÖTÜ
*/
import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<String> myList = ['Koray', 'Temizkan', 'Neon', 'Apps'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      // En dışa bu CustomScrollView koyuyoruz, Her şeyi taşıyan ana öge bu.
      // SLiver için Box Widgetleri koymamamız gerekiyormuş.
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text('Dikey List View'),
                ListView(
                  shrinkWrap: true,
                  children: [Text('1'), Text('2'), Text('3')],
                ),

                SizedBox(height: 12),
                Divider(height: 2),
                SizedBox(height: 12),

                Text('Yatay List View'), // Height vermezsen
                Container(
                  decoration: BoxDecoration(color: Colors.red),
                  height: 24,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [Text('1'), Text('2'), Text('2')],
                  ),
                ),

                SizedBox(height: 12),
                Divider(height: 2),
                SizedBox(height: 12),

                // Mesela bir liste alsak myList.length diyip dinamik yapabiliyoruz
                Text('ListView.builder'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    final item = myList[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('${item}'),
                      ),
                    );
                  },
                ),

                SizedBox(height: 12),
                Divider(height: 2),
                SizedBox(height: 12),

                Text('SliverList ve biraz daha aşağıda SliverGrid'),
              ],
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Card(
                color: Colors.blue,
                child: ListTile(
                  title: Text('Başlık'),
                  subtitle: Text('Altyazı'),
                ),
              ),
              childCount: 5,
            ),
          ),

          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Card(margin: const EdgeInsets.all(16),child: Text('test'));
            },childCount: 5),
            // sabit sütun sayısı belirlerken bu kullanılır
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 1,
            ),
          ),
        ],
      ),
    );
  }
}
