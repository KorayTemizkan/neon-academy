// KORAY BURAYA GERİ DÖN

import 'package:data_table/passenger_model.dart';
import 'package:data_table/passenger_view.dart';
import 'package:flutter/material.dart';

// Enum veri yapımızı segmented butonumuz için kurduk
enum Segment { name, surname }

class DataTableView extends StatefulWidget {
  // 16 tane kişiyi hızlıca model üzerinden kurdum listeye atadım.
  final List<PassengerModel> passengerList = [
    PassengerModel(
      name: "Koray",
      surname: "Temizkan",
      team: "Flutter Team",
      age: 22,
      hometown: "İstanbul",
      mail: "koray@tigcik.com",
    ),
    PassengerModel(
      name: "Selin",
      surname: "Yıldız",
      team: "iOS Team",
      age: 21,
      hometown: "Trabzon",
      mail: "selinyildiz@swift.org",
    ),
    PassengerModel(
      name: "Deniz",
      surname: "Şahin",
      team: "Flutter Team",
      age: 26,
      hometown: "Samsun",
      mail: "deniz.sahin@dart.dev",
    ),
    PassengerModel(
      name: "Oğuz",
      surname: "Kılıç",
      team: "Flutter Team",
      age: 27,
      hometown: "Samsun",
      mail: "oguz.kilic@flutter.io",
    ),
    PassengerModel(
      name: "Ahmet",
      surname: "Yılmaz",
      team: "iOS Team",
      age: 25,
      hometown: "Ankara",
      mail: "ahmet.yilmaz@apple.com",
    ),
    PassengerModel(
      name: "Ece",
      surname: "Aydın",
      team: "iOS Team",
      age: 24,
      hometown: "Bursa",
      mail: "ece.aydin@ios.com",
    ),
    PassengerModel(
      name: "Can",
      surname: "Yıldız",
      team: "Flutter Team",
      age: 26,
      hometown: "Antalya",
      mail: "can.yildiz@dev.com",
    ),
    PassengerModel(
      name: "Burak",
      surname: "Arslan",
      team: "iOS Team",
      age: 29,
      hometown: "Antalya",
      mail: "burakarslan@xcode.com",
    ),
    PassengerModel(
      name: "Mehmet",
      surname: "Demir",
      team: "Android Team",
      age: 30,
      hometown: "Adana",
      mail: "m.demir01@android.com",
    ),
    PassengerModel(
      name: "Merve",
      surname: "Çelik",
      team: "Android Team",
      age: 28,
      hometown: "Muğla",
      mail: "merve.celik@kotlin.com",
    ),
    PassengerModel(
      name: "Mert",
      surname: "Kaya",
      team: "Android Team",
      age: 31,
      hometown: "Bursa",
      mail: "mert_kaya16@jetpack.net",
    ),
    PassengerModel(
      name: "Ayşe",
      surname: "Kaya",
      team: "Design Team",
      age: 23,
      hometown: "İzmir",
      mail: "ayse.kaya@figma.com",
    ),
    PassengerModel(
      name: "Selin",
      surname: "Demir",
      team: "Design Team",
      age: 24,
      hometown: "İzmir",
      mail: "selin.demir@adobe.com",
    ),
    PassengerModel(
      name: "Hakan",
      surname: "Yılmaz",
      team: "Android Team",
      age: 28,
      hometown: "Ankara",
      mail: "hakan.ylmz@google.com",
    ),
    PassengerModel(
      name: "Elif",
      surname: "Şahin",
      team: "Design Team",
      age: 23,
      hometown: "Eskişehir",
      mail: "elif_sahin@ux.ui",
    ),
    PassengerModel(
      name: "Zeynep",
      surname: "Aksoy",
      team: "Design Team",
      age: 19,
      hometown: "Trabzon",
      mail: "zeynepaksoy@palette.com",
    ),
  ];

  @override
  State<DataTableView> createState() => _DataTableViewState();
}

class _DataTableViewState extends State<DataTableView> {
  // Listeyi karışık yaptım bilerek ki bu arrayleri tekrar edeyim, ilk hafta kodlarıma baktım.

  List<PassengerModel> sortTeams(List<PassengerModel> myPassengerList) {
    setState(() {
      return myPassengerList.sort(
        (a, b) => a.team.toLowerCase().compareTo((b.team.toLowerCase())),
      );
    });
    return myPassengerList;
  }

  Segment _selectedSegment = Segment.name;

  @override
  Widget build(BuildContext context) {
    // yeni listemizi oluşturmuş olduk
    List<PassengerModel> myNewList = sortTeams(widget.passengerList);

    return Scaffold(
      appBar: AppBar(title: Text('Data Table'), backgroundColor: Colors.blue),

      // İç içe hem dikey hem yatay kaydırma böyle yapılıyormuş
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          // https://api.flutter.dev/flutter/material/DataTable-class.html
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Burayı önceki görevlerden aldım zaten kod mantığı aynı
              SegmentedButton<Segment>(
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: Colors.pinkAccent,
                  backgroundColor: Colors.purple,
                  selectedForegroundColor: Colors.white,
                ),
                segments: const <ButtonSegment<Segment>>[
                  ButtonSegment(value: Segment.name, label: Text('Ad')),
                  ButtonSegment(value: Segment.surname, label: Text('Soyad')),
                ],
                selected: <Segment>{_selectedSegment},
                onSelectionChanged: (Set<Segment> newSelection) {
                  setState(() {
                    _selectedSegment = newSelection.first;
                  });
                },
              ),

              // https://api.flutter.dev/flutter/material/SearchBar-class.html
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchAnchor(
                  builder: (BuildContext context, controller) {
                    return SearchBar(
                      controller: controller,
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                      hintText: _selectedSegment == Segment.name
                          ? 'Adla ara'
                          : 'Soyadla Ara',
                    );
                  },

                  // Burası bana çok karışık geliyordu, kendi projemde de zorlandım, geri dönüp bak Koray
                  suggestionsBuilder: (BuildContext context, controller) {
                    // Kullanıcının yazdığı metni küçük harfe çevirip aldık.
                    final String input = controller.value.text.toLowerCase();
                    
                    // Liste içindeki her bir yolcuyu sırayla gezicez
                    return myNewList
                        .where((element) {
                          if (_selectedSegment == Segment.name) {
                            // Biz a yazdık diyelim ve segment ad seçilili. Listeyi gezerken o andaki modelin adında a varsa map aşamasına geziyoruz ve bilgilerini yazdırıyoruz
                            return element.name.toLowerCase().contains(input); // Bir şey yazmadan da karşımıza öneriler çıkmasının sebebi boş stringin teknik olarak tüm stringlerde olmasıymış
                          } else {
                            return element.surname.toLowerCase().contains(
                              input,
                            );
                          }
                        })
                        .map(
                          (e) => ListTile(
                            title: Text('${e.name},${e.surname}'),
                            subtitle: Text('${e.age}'),

                            onTap: () {
                              controller.closeView(e.name);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PassengerView(passenger: e),
                                ),
                              );
                            },
                          ),
                        ).toList();
                  },
                ),
              ),

              DataTable(
                showCheckboxColumn: false,
                columns: const <DataColumn>[
                  DataColumn(label: Text('Ad')),
                  DataColumn(label: Text('Soyad')),
                  DataColumn(label: Text('Takım')),
                  DataColumn(label: Text('Yaş')),
                  DataColumn(label: Text('Memleket')),
                  DataColumn(label: Text('Mail')),
                ],

                rows: myNewList.map((e) {
                  return DataRow(
                    onSelectChanged: (bool? selected) {
                      if (selected != null && selected) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PassengerView(passenger: e),
                          ),
                        );
                      }
                    },
                    cells: [
                      DataCell(Text(e.name)),
                      DataCell(Text(e.surname)),
                      DataCell(Text(e.team)),
                      DataCell(Text(e.age.toString())),
                      DataCell(Text(e.hometown)),
                      DataCell(Text(e.mail)),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
