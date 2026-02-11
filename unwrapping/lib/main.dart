// BU KONU YORUCU DAHA SONRA GERİ DÖN

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

  // Model servisimiz üzerinden listemize atama yapıyoruz.
  Future<void> fetch() async {
    final data = await fetchNeonAcademyMembers();
    setState(() {
      neonAcademyMembers = data;
      debugInteger = 0;
      debugString = 'Debug';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  /* Create a function that prints out a message based on the member's motivation level.
  For example, if the motivation level is nil, the function should print out "This member
  has no motivation level set" and if the motivation level is greater than 5, the function 
  should print out "This member is highly motivated". ( You should use guard let for this task) */

  void message(String member) {
    var fmember = neonAcademyMembers.firstWhere(
      (element) => element.fullName == member,
    );

    setState(() {
      if (fmember.fullName.isNotEmpty) {
        final fmotivation =
            fmember.motivationLevel; // böyle soyutlama iyi bir alışkanlık

        if (fmotivation == null) { // BUNA GUARDLAMA DENİYOR YANİ RETURN İLE EARLY EXİT
          debugString = 'This member has no motivation level set';
          return; // return verip koruma sağlıyoruz
        }

        if (fmotivation > 5) {
          debugString = 'This member is highly motivated';
        }
      }
    });
  }

  /*
  Create a function that takes a member's motivation level as an input and returns a string indicating
  whether the member is highly motivated, moderately motivated, or not motivated at all.
  */

  void getMotivationStatus(int? level) {
    final fmotivation = level;
    setState(() {
      if (fmotivation == null || fmotivation < 4) {
        debugString = 'This member has no motivation at all';
        return; // return verip koruma sağlıyoruz
      }

      if (fmotivation > 4 && fmotivation <= 7) {
        debugString = 'This member is moderately motivated';
      }

      if (fmotivation > 7) {
        debugString = 'This member is highly motivated';
      }
    });
  }

  /*Create a function that takes a member and returns the member's motivation level
  if it is not nil, otherwise it returns 0. ( You should use nil coalescing for this task)*/

  int isZeroMotivated(NeonAcademyMemberModel member) {
    final fmotivation = member.motivationLevel;

    return fmotivation ?? 0; // BUNA (nil coalescing) DİYORLAR
  }

  /* 
  Create a function that takes a member and a target motivation level as inputs,
  and returns true if the member's current motivation level is greater than or equal to
  the target level, or false otherwise. ( You should use iv let for this task)
  */

  bool compare(NeonAcademyMemberModel member, int targetMotivation) {
    final fmotivation =
        member.motivationLevel; // böyle soyutlama iyi bir alışkanlık

    if (fmotivation == null || fmotivation < targetMotivation) {
      debugString = 'Az ya da hiç motivasyon';
      return false; // return verip koruma sağlıyoruz
    }

    debugString = 'Çok ya da eşit motivasyon';
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (neonAcademyMembers.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
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

                    myButton(() {
                      message('Zeynep Dandin');
                    }, "Zeynep Dandin kişisinin motivasyon seviyesi"),

                    myButton(
                      // BURASI ÇOK ÖNEMLİ KORAY
                      () {
                        var mehmet = neonAcademyMembers.where(
                          (element) => element.fullName == 'Mehmet Nuri Fırat',
                        );

                        if (mehmet.isNotEmpty) {
                          getMotivationStatus(mehmet.first.motivationLevel);
                        }
                      },
                      'Mehmet Nuri Fırat kişisininin motivasyon düzeyi (3 düzey)',
                    ),

                    myButton(() {
                      var mehmet = neonAcademyMembers.where(
                        (element) => element.fullName == 'Mehmet Nuri Fırat',
                      );

                      mehmet.first.increaseMotivation(1);

                      if (mehmet.isNotEmpty) {
                        setState(() {
                          mehmet.first.increaseMotivation(1);
                          debugInteger = isZeroMotivated(mehmet.first);
                          debugString = "Motivation Level";
                        });
                      }
                    }, "Mehmet Nuri'nin motivasyonunu arttır ve göster"),

                    myButton(() {
                      var mehmet = neonAcademyMembers.where(
                        (element) => element.fullName == 'Mehmet Nuri Fırat',
                      );

                      if (mehmet.isNotEmpty) {
                        setState(() {
                          bool result = compare(mehmet.first, 3);
                          debugString = "Karşılaştırma = ${result}";
                        });
                      }
                    }, "Mehmet Nuri'nin motivasyonu 3'ten büyük mü?"),
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
                        Text('Takımı: ${member.teamName}'),
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

  // Tekrar kullanılabilir buton fonksiyonu
  Widget myButton(VoidCallback func, String text) {
    return ElevatedButton(
      onPressed: func,
      child: Text(text, style: const TextStyle(color: Colors.red)),
    );
  }
}
