import 'package:flutter/material.dart';
import 'package:struct_class/model_service.dart';
import 'package:struct_class/models/contact_information_model.dart';
import 'package:struct_class/models/neon_academy_member_model.dart';

// JSON dosyasını Slack üzerinden aldım ve eksik bilgileri ChatGPT ile doldurtarak oluşturdum.
// Kendi projemde de JSON ile veri çekme yöntemini kullandığım için böyle yapmayı tercih ettim.

// ! Hata yakalamaları bilerek eklemedim test amaçlı olduğu için. (Fonksiyonlar da başka dosyaya alınabilir ama demo olduğu için gerek duymadım)

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
  // Listemiz
  List<NeonAcademyMemberModel> neonAcademyMembers = [];

  // Model servisimiz üzerinden listemize atama yapıyoruz.
  Future<void> fetch() async {
    final data = await fetchNeonAcademyMembers();
    setState(() {
      neonAcademyMembers = data;
    });
  }

  // StatefullWidgetlerde widget açılışında bir kere çalışan bir döngü metodudur.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  /* JSON ile veri çekme yerine teker teker böyle de yapılabilir bu arada

  ContactInformationModel korayscontact = ContactInformationModel(
    email: "koray@gmail.com",
    phoneNumber: 555 555 55 55
  );

  NeonAcademyMemberModel koraymember = NeonAcademyMemberModel(
    fullName: "Koray",
    age : 22,
    contact: korayscontact,
    ...
  );

  */

  // Build metodu her state değişimi sonrası yeniden çizilir.
  @override
  Widget build(BuildContext context) {
    if (neonAcademyMembers.isEmpty) {
      return Scaffold(body: Center(child: const CircularProgressIndicator()));
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),

          Text(
            'LİSTEMİZ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 36),
          ),

          Expanded(
            child: ListView.builder(
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
                        Text('Email : ${member.contact.phoneNumber}'),
                        Text('Telefon : ${member.contact.email}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}