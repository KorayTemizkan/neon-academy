import 'package:flutter/material.dart';
import 'package:struct_class/model_service.dart';
import 'package:struct_class/models/contact_information_model.dart';
import 'package:struct_class/models/neon_academy_member_model.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<NeonAcademyMemberModel> neonAcademyMembers = [];
  List<NeonAcademyMemberModel> backUp = [];
  int debugInteger = 0;
  String debugString = "Debug";
  TextEditingController _questionController = TextEditingController();

  Future<void> fetch() async {
    fetchNeonAcademyMembers().then((data) {
      setState(() {
        neonAcademyMembers = data;
        debugInteger = 0;
        debugString = "Debug";
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  Future<void> printCurrentIndex() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bulmak istediğiniz kişinin adını girin'),
                TextField(controller: _questionController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                try {
                  final member = neonAcademyMembers.firstWhere(
                    (m) =>
                        m.fullName.toLowerCase() ==
                        _questionController.text.toLowerCase(),
                  );

                  setState(() {
                    debugInteger = neonAcademyMembers.indexOf(member);
                  });

                  print('Index: $debugInteger');
                } catch (e) {
                  print('Üye bulunamadı');
                }

                Navigator.of(context).pop();
              },
              child: const Text('Kontrol'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addNewMentor() async {
    ContactInformationModel mentorContact = ContactInformationModel(
      email: 'koray@gmail.com',
      phoneNumber: '555 555 55 55',
    );
    setState(() {
      neonAcademyMembers.add(
        NeonAcademyMemberModel(
          fullName: "Koray",
          title: "Flutter Dev",
          horoscope: "Akrep",
          memberLevel: "A2",
          homeTown: "Kırıkkale",
          age: 22,
          mentorLevel: 'F1',
          contact: mentorContact,
        ),
      );

      debugString = 'Yeni Mentor Eklendi';
    });
  }

  Future<void> removeA1Levels() async {
    setState(() {
      neonAcademyMembers.removeWhere((element) => element.memberLevel == 'A1');
      debugString = 'A1 düzeyindeki kişiler kaldırıldı';
    });
  }

  Future<void> numberOfFlutterDevs() async {
    setState(() {
      debugInteger = neonAcademyMembers
          .where((element) => element.title == 'Flutter Developer')
          .length;
      debugString = 'Flutter Geliştiricisi Sayısı';
    });
  }

  // https://ekimunyime.medium.com/exploring-array-manipulation-in-dart-flutter-db88f806a769
  Future<void> filterAndTransfer() async {
    setState(() {
      neonAcademyMembers = neonAcademyMembers
          .where((element) => element.age > 24)
          .toList();
    });
  }

  //https://dev.to/newtonmunene_yg/essential-dart-list-array-methods-if7
  Future<void> delete(int index) async {
    if (index >= 0 && index < neonAcademyMembers.length) {
      setState(() {
        neonAcademyMembers.removeAt(index);
      });
    }
  }

  //https://dev.to/newtonmunene_yg/essential-dart-list-array-methods-if7
  Future<void> sortAge() async {
    setState(() {
      neonAcademyMembers.sort((b, a) => a.age.compareTo(b.age));
    });
  }

  //https://stackoverflow.com/questions/27897932/sorting-ascending-and-descending-in-dart
  Future<void> sortAlphabetically() async {
    setState(() {
      neonAcademyMembers.sort(
        (b, a) =>
            a.fullName.toLowerCase().compareTo((b.fullName.toLowerCase())),
      );
    });
  }

  Future<void> groupPeopleByMemberLevel() async {
    // A1, A2, A3, B1, B2, S1, S3 (Member Level ilk elemanları büyük olanları sırala, sonra bu sıralamanın içindekileri tekrar 1,2'ye göre sırala)
    setState(() {
      /* Kendi denemem
      neonAcademyMembers.sort(
        (a, b) => a.memberLevel.toLowerCase()[0].compareTo(
          b.memberLevel.toLowerCase()[0],
        ),
      );
      */

      // Kendi fonksiyonu zaten varmış uğraşmaya gerek yok
      neonAcademyMembers.sort((a, b) {
        return a.memberLevel.toLowerCase().compareTo(
          b.memberLevel.toLowerCase(),
        );
      });
    });
  }

  Future<void> oldestOne() async {
    setState(() {
      debugInteger = neonAcademyMembers
          .reduce((a, b) => a.age > b.age ? a : b)
          .age;
      debugString = neonAcademyMembers
          .reduce((a, b) => a.age > b.age ? a : b)
          .fullName;
    });
  }

  Future<void> longestName() async {
    setState(() {
      debugString = neonAcademyMembers
          .reduce((a, b) => a.fullName.length > b.fullName.length ? a : b)
          .fullName;
      debugInteger = debugString.length;
    });
  }

  Future<void> groupPeopleByHoroscope() async {
    setState(() {
      backUp = neonAcademyMembers
          .where((element) => element.horoscope == 'Koç')
          .toList();
      neonAcademyMembers =
          backUp; // Burada Card yapımda ekrana yazdırdığım için ek olarak fonksiyon eklemek istemedim. Yeni listeye kopyalandığını göstermek için süreci uzattım.
    });
  }

  // en yorucusu buydu
  // https://dev.to/jrmatanda/how-to-remove-duplicates-from-an-array-in-dart-a5m
  Future<void> groupPeopleByTitle() async {
    // Flutter Developer 3 tane, ios developer 4 tane mesela,
    // titleları listeye al, daha sonra aynı elemanları listeden sil. 3 elemanlı liste kaldı
    // sonra bu elemanlara göre yeni neonacademymemberCOntact listeleri oluştur,
    setState(() {
      var neonAcademyMemberTitles = neonAcademyMembers
          .map((e) => e.title)
          .toList()
          .toSet();

      debugString = '\nUNVANLAR:\n';
      for (var element in neonAcademyMemberTitles) {
        debugString += '\n';
        debugString += element;
      }

      debugString += '\n\n\nGRUPLANDIRMALAR:\n\n';

      for (var elementUpper in neonAcademyMemberTitles) {
        List<ContactInformationModel> contactList = neonAcademyMembers
            .where((element) => element.title == elementUpper)
            .map((e) => e.contact)
            .toList();

        debugString +=
            '${elementUpper}: ${contactList.map((element) => element.phoneNumber).toString()}\n';
      }
    });
  }

  Future<void> mostCommonHometown() async {
    // 111332
    setState(() {
      var neonAcademyMembersHometowns = neonAcademyMembers
          .map((e) => e.homeTown)
          .toList();

      var counts = {};

      for (var element in neonAcademyMembersHometowns) {
        counts[element] = (counts[element] ?? 0) + 1; // Güzel bir yol
      }

      var mostFrequent = counts.entries
          .reduce((a, b) => a.value > b.value ? a : b); // key value olarak tutuluyor. kaç tane olduğu değil hangi sayı olduğunu istiyoruz. (Bu map yapısına dikkat hep list kullandık)

      debugString = mostFrequent.key;
      debugInteger = mostFrequent.value;
    });
  }

  Future<void> fetchContactInfos() async {
    //Map iterable olduğu için seçim böyle oluyor
    setState(() {
      List<String> emailAdresses = neonAcademyMembers
          .map((element) => element.contact.email)
          .toList();
      for (var element in emailAdresses) {
        debugString += '\n';
        debugString += element;
      }
    });
  }

  Future<void> averageAge() async {
    setState(() {
      var ages = neonAcademyMembers
          .where((element) => element.age > 0)
          .map((e) => e.age)
          .toList();
      /*
      for (var element in ages) {
        debugInteger += element;
      }*/ // bu yöntem doğru sonuç üretmiyor
      int toplam = ages.reduce(
        (value, element) => value + element,
      ); // güzel bir fonksiyon c++'da yoktu

      debugInteger ~/= ages.length; // /= Dart dilinde her zaman double üretir.
    });
  }

  @override
  Widget build(BuildContext context) {
    if (neonAcademyMembers.isEmpty) {
      return const CircularProgressIndicator();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),

            Card(
              margin: EdgeInsets.all(16),
              elevation: 1,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'KONTROL PANELİ\nLİSTE AŞAĞIDA',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 36),
                    ),

                    // https://dev.to/newtonmunene_yg/essential-dart-list-array-methods-if7
                    ElevatedButton(
                      onPressed: () {
                        delete(2);
                      },
                      child: Text(
                        '3. kişiyi Sil',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    // https://stackoverflow.com/questions/27897932/sorting-ascending-and-descending-in-dart
                    ElevatedButton(
                      onPressed: () {
                        sortAge();
                      },
                      child: Text(
                        'Yaşlara göre büyükten küçüğe sırala',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        sortAlphabetically();
                      },
                      child: Text(
                        'Alfabenin tersine göre sırala',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        filterAndTransfer();
                      },
                      child: Text(
                        '24 yaşından büyük kişileri yeni bir diziye aktar ve yeni dizinin elemanlarını yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        numberOfFlutterDevs();
                      },
                      child: Text(
                        'Flutter geliştirisi sayısını yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        printCurrentIndex();
                      },
                      child: Text(
                        'Kişi Adı gir ve indexini gör',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        addNewMentor();
                      },
                      child: Text(
                        'Mentor düzeyinde kişi ekle',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        removeA1Levels();
                      },
                      child: Text(
                        'A1 düzeyindeki kişileri kaldır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        oldestOne();
                      },
                      child: Text(
                        'En büyük kişinin bilgilerini yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        longestName();
                      },
                      child: Text(
                        'En uzun ada sahip kişinin bilgilerini yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        groupPeopleByHoroscope();
                      },
                      child: Text(
                        'Koç burcuna sahip olanları grupla',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        mostCommonHometown();
                      },
                      child: Text(
                        'En yaygın memleketi yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        averageAge();
                      },
                      child: Text(
                        'Ortalama yaşı yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        fetchContactInfos();
                      },
                      child: Text(
                        'Mail adreslerini yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        groupPeopleByMemberLevel();
                      },
                      child: Text(
                        'Kıdem düzeyine göre sırala',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        groupPeopleByTitle();
                      },
                      child: Text(
                        'Unvana göre telefon numaralarını yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fetch();
                        });
                      },
                      child: Text(
                        'Sıfırla',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Card(
              margin: const EdgeInsets.all(16),
              elevation: 1,

              child: Padding(
                padding: const EdgeInsetsGeometry.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('DEBUG EKRANI:'),
                    Text('$debugString: $debugInteger'),
                  ],
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: neonAcademyMembers.length,
              itemBuilder: (context, index) {
                final member = neonAcademyMembers[index];

                return Card(
                  margin: EdgeInsets.all(16),
                  elevation: 1,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Index: ${index}'),
                        Text('Ad: ${member.fullName}'),
                        Text('Unvan: ${member.title}'),
                        Text('Yaş: ${member.age}'),
                        Text('Memleket: ${member.homeTown}'),
                        Text('Burç: ${member.horoscope}'),
                        Text('Düzey: ${member.memberLevel}'),
                        Text('Email : ${member.contact.email}'),
                        Text('Telefon : ${member.contact.phoneNumber}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
