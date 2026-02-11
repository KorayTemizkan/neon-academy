import 'package:flutter/material.dart';
import 'package:struct_class/model_service.dart';
import 'package:struct_class/models/contact_information_model.dart';
import 'package:struct_class/models/neon_academy_member_model.dart';

// JSON dosyasını Slack üzerinden aldım ve eksik bilgileri ChatGPT ile doldurtarak oluşturdum.
// Kendi projemde de JSON ile veri çekme yöntemini kullandığım için böyle yapmayı tercih ettim.

// ! Hata yakalamaları bilerek eklemedim test amaçlı olduğu için. (Fonksiyonlar da başka dosyaya alınabilir ama demo olduğu için gerek duymadım)
// Olabildiğince az yapay zeka kullanmaya çalıştım. Kullandığım kaynakların bazılarına fonksiyonların üstlerine ekledim.

void main() {
  runApp(MaterialApp(home: MyApp()));
}

// UI yeniden çizimi, state değişimleri, atamalar olduğu için stateless yapamayız.
// State ekranda değişebilen her şeydir. Bir durum, varlıktır. Değişme imkanı vardır. Enerji gibi düşün.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Listelerimiz
  List<NeonAcademyMemberModel> neonAcademyMembers = [];
  List<NeonAcademyMemberModel> backUp = [];

  // Görsel olarak anlık veri takibi yaparız.
  int debugInteger = 0;
  String debugString = "Debug";

  // Girdi almak için kullanılır.
  TextEditingController _questionController = TextEditingController();

  // Model servisimiz üzerinden listemize atama yapıyoruz.
  Future<void> fetch() async {
    final data = await fetchNeonAcademyMembers();
    setState(() {
      neonAcademyMembers = data;
      debugInteger = 0;
      debugString = '';
    });
  }

  // StatefullWidgetlerde widget açılışında bir kere çalışan bir döngü metodudur.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  // Bu fonksiyonu şu anda geliştirdiğim "Tığcık" projemden aldım. Basit bir bildirim fonksiyonu
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
                        _questionController.text.toLowerCase().trim(),
                  );

                  setState(() {
                    debugInteger = neonAcademyMembers.indexOf(member);
                    debugString = 'Kişi indexi';
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

  void addNewMentor() {
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

      debugString = 'Koray mentorü eklendi';
    });
  }

  void removeA1Levels() {
    setState(() {
      neonAcademyMembers.removeWhere((element) => element.memberLevel == 'A1');
      debugString = 'A1 düzeyindeki kişiler kaldırıldı';
    });
  }

  void numberOfFlutterDevs() {
    setState(() {
      debugInteger = neonAcademyMembers
          .where((element) => element.title == 'Flutter Developer')
          .length;
      debugString = 'Flutter Geliştiricisi Sayısı';
    });
  }

  // https://ekimunyime.medium.com/exploring-array-manipulation-in-dart-flutter-db88f806a769
  void filterAndTransfer() {
    setState(() {
      neonAcademyMembers = neonAcademyMembers
          .where((element) => element.age > 24)
          .toList();
      debugString = 'Kişiler filtrelendi';
    });
  }

  //https://dev.to/newtonmunene_yg/essential-dart-list-array-methods-if7
  void delete(int index) {
    if (index >= 0 && index < neonAcademyMembers.length) {
      setState(() {
        neonAcademyMembers.removeAt(index);
        debugString = 'Kişi silindi';
      });
    }
  }

  //https://dev.to/newtonmunene_yg/essential-dart-list-array-methods-if7
  void sortAge() {
    setState(() {
      neonAcademyMembers.sort((b, a) => a.age.compareTo(b.age));
      debugString = 'Sıralandı';
    });
  }

  //https://stackoverflow.com/questions/27897932/sorting-ascending-and-descending-in-dart
  void sortAlphabetically() {
    setState(() {
      neonAcademyMembers.sort(
        (b, a) =>
            a.fullName.toLowerCase().compareTo((b.fullName.toLowerCase())),
      );
      debugString = 'Sıralandı';
    });
  }

  void groupPeopleByMemberLevel() {
    // A1, A2, A3, B1, B2, S1, S3 (Member Level ilk elemanları büyük olanları sırala, sonra bu sıralamanın içindekileri tekrar 1,2'ye göre sırala)
    setState(() {
      /* Kendi denemem ama tam olmadı
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

      debugString = 'Kıdem düzeyine göre sıralandı';
    });
  }

  // https://api.flutter.dev/flutter/dart-collection/ListQueue/reduce.html
  void oldestOne() {
    setState(() {
      debugInteger = neonAcademyMembers
          .reduce((a, b) => a.age > b.age ? a : b)
          .age;
      debugString = neonAcademyMembers
          .reduce((a, b) => a.age > b.age ? a : b)
          .fullName;
    });
  }

  void longestName() {
    setState(() {
      debugString = neonAcademyMembers
          .reduce((a, b) => a.fullName.length > b.fullName.length ? a : b)
          .fullName;
      debugInteger = debugString.length;
    });
  }

  void groupPeopleByHoroscope() {
    setState(() {
      backUp = neonAcademyMembers
          .where((element) => element.horoscope == 'Koç')
          .toList();
      neonAcademyMembers =
          backUp; // Burada Card yapımda ekrana yazdırdığım için ek olarak fonksiyon eklemek istemedim. Yeni listeye kopyalandığını göstermek için süreci uzattım.
      debugString = 'Koç burcu olanlar sıralandı';
    });
  }

  // en yorucusu buydu
  // https://dev.to/jrmatanda/how-to-remove-duplicates-from-an-array-in-dart-a5m
  void groupPeopleByTitle() {
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

  void mostCommonHometown() {
    // 111332
    setState(() {
      var neonAcademyMembersHometowns = neonAcademyMembers
          .map((e) => e.homeTown)
          .toList();

      var counts = {};

      for (var element in neonAcademyMembersHometowns) {
        counts[element] = (counts[element] ?? 0) + 1; // Güzel bir yol
      }

      var mostFrequent = counts.entries.reduce(
        (a, b) => a.value > b.value ? a : b,
      ); // key value olarak tutuluyor. kaç tane olduğu değil hangi sayı olduğunu istiyoruz. (Bu map yapısına dikkat hep list kullandık)

      debugString = mostFrequent.key;
      debugInteger = mostFrequent.value;
    });
  }

  void fetchContactInfos() {
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

  void averageAge() {
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

      debugInteger =
          toplam ~/ ages.length; // /= Dart dilinde her zaman double üretir.
      debugString = 'Ortalama yas';
    });
  }

  // Build metodu her state değişimi sonrası yeniden çizilir.
  @override
  Widget build(BuildContext context) {
    if (neonAcademyMembers.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),

            Card(
              margin: const EdgeInsets.all(16),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'KONTROL PANELİ\n(Liste Aşağıda)\n(Her işlem öncesi sıfırlayınız)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 36),
                    ),

                    myButton(() => fetch(), '* SIFIRLA *'),
                    myButton(() => delete(2), '3. kişiyi Sil'),
                    myButton(sortAge, 'Yaşlara göre büyükten küçüğe sırala'),
                    myButton(
                      sortAlphabetically,
                      'Alfabenin tersine göre sırala',
                    ),
                    myButton(
                      filterAndTransfer,
                      '24 yaşından büyük kişileri filtrele',
                    ),
                    myButton(
                      numberOfFlutterDevs,
                      'Flutter geliştiricisi sayısını yazdır',
                    ),
                    myButton(printCurrentIndex, 'Kişi adı gir ve indexini gör'),
                    myButton(addNewMentor, 'Koray mentorunu ekle'),
                    myButton(removeA1Levels, 'A1 düzeyindeki kişileri kaldır'),
                    myButton(oldestOne, 'En büyük kişinin bilgilerini yazdır'),
                    myButton(longestName, 'En uzun ada sahip kişiyi yazdır'),
                    myButton(
                      groupPeopleByHoroscope,
                      'Koç burcuna sahip olanları grupla',
                    ),
                    myButton(mostCommonHometown, 'En yaygın memleketi yazdır'),
                    myButton(averageAge, 'Ortalama yaşı yazdır'),
                    myButton(fetchContactInfos, 'Mail adreslerini yazdır'),
                    myButton(
                      groupPeopleByMemberLevel,
                      'Kıdem düzeyine göre sırala',
                    ),
                    myButton(
                      groupPeopleByTitle,
                      'Unvana göre telefon numaralarını yazdır',
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
              shrinkWrap: true, // İçindeki elemanlar kadar yer kapla
              physics:
                  const NeverScrollableScrollPhysics(), // Zaten yukarıda kaydırılabilirlik vermiştik burayı kapatıyoruz.
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

  // Tekrar kullanılabilir buton fonksiyonumuz
  ElevatedButton myButton(VoidCallback func, String text) {
    return ElevatedButton(
      onPressed: func,
      child: Text(text, style: TextStyle(color: Colors.red)),
    );
  }
}