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

  /* Create a dictionary that contains the number of members in each team, and print out the number of members in the UI/UX Design Team. */
  void makeDictionary() {
    Map<Team, int> countMembersTeams = {
      Team.flutterDevelopmentTeam: 0,
      Team.androidDevelopmentTeam: 0,
      Team.iOSDevelopmentTeam: 0,
      Team.uiUxDesignTeam: 0,
    };

    // Çok ilginç
    for (var element in neonAcademyMembers) {
      countMembersTeams[element.team] =
          (countMembersTeams[element.team] ?? 0) + 1;
    }

    setState(() {
      debugString = 'Toplam UI UX takım üyesi sayı';

      debugInteger =
          countMembersTeams[Team.uiUxDesignTeam] ??
          0; // mapten gelen nullabledır. sen sıfır ile derleyiciye güvence vermelisin.
    });
  }

  void getFlutterTeamMembers() {
    setState(() {
      backUp = neonAcademyMembers
          .where((element) => element.team == Team.flutterDevelopmentTeam)
          .toList();

      neonAcademyMembers = backUp;

      debugString = 'Sıralandı';
    });
  }

  // Create a function that takes a team as an input and prints out the full names of all members in that team.
  // FLutter DEveleoper enumunu alıp bu takımdakilerin adlarını yazalım
  void getFlutterDevs(Team f_team) async {
    var names = neonAcademyMembers
        .where((element) => element.team == f_team)
        .toList();

    setState(() {
      debugString = names.map((e) => e.fullName).toString();
    });
  }

  /* Create a switch statement that performs different actions based on the team of a member.
  For example, if a member is in the Flutter Development Team, the function could print out
  "This member is a skilled Flutter developer", and if the member is in the UI/UX Design Team, 
  the function could print out "This member is a talented designer". */

  // Bu fonksiyonu şu anda geliştirdiğim "Tığcık" projemden aldım. Basit bir bildirim fonksiyonu
  Future<void> makeSwitchDialog() async {
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

                  makeSwitch(member.fullName);
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

  void makeSwitch(String fcontroller) {
    NeonAcademyMemberModel member = neonAcademyMembers.firstWhere(
      (element) => element.fullName.toLowerCase() == fcontroller.toLowerCase(),
    );

    setState(() {
      if (member.fullName.isNotEmpty) {
        switch (member.team) {
          case Team.flutterDevelopmentTeam:
            debugString = 'Kullanıcının takımı: Flutter Takımı';
            break;
          case Team.iOSDevelopmentTeam:
            debugString = 'Kullanıcının takımı: iOS Takımı';
            break;
          case Team.androidDevelopmentTeam:
            debugString = 'Kullanıcının takımı: Android Takımı';
            break;
          case Team.uiUxDesignTeam:
            debugString = 'Kullanıcının takımı: UiUx Takımı';
            break;
          default:
            debugString = "Bu kullanıcı hiçbir takımda yok";
            break;
        }
      }
    });
  }

  // Create a switch statement that prints out a different message for each team,
  //such as "The Flutter Development Team is the backbone of our academy" for the
  //Flutter Development Team and "The UI/UX Design Team is the face of our academy"
  //for the UI/UX Design Team.

  void message() {
    setState(() {
      // switch tek bir enum değer üzerinde çalışıyor
      debugString = '';
      for (var element in Team.values) {
        switch (element) {
          case Team.flutterDevelopmentTeam:
            debugString += 'En iyisi Flutter\n';
            break;
          case Team.iOSDevelopmentTeam:
            debugString += 'En iyisi iOS\n';
            break;
          case Team.androidDevelopmentTeam:
            debugString += 'En iyisi Android\n';
            break;
          case Team.uiUxDesignTeam:
            debugString += 'En iyisi UI & UX\n';
            break;
        }
      }
    });
  }

  /*
  Create a switch statement that performs different actions based on the team of a member
  and their age. For example, if a member is in the Flutter Development Team and is over
  23 years old, the function could print out "XXX member is a seasoned Flutter developer",
  and if the member is in the UI/UX Design Team and is under 24, the function could print out
  "XXX member is a rising star in the design world".
  */

  void seniorityLevel(String fcontroller) {
    try {
      NeonAcademyMemberModel member = neonAcademyMembers.firstWhere(
        (element) =>
            element.fullName.toLowerCase() == fcontroller.toLowerCase(),
      );

      setState(() {
        switch (member.team) {
          case Team.flutterDevelopmentTeam:
            debugString = member.age > 24
                ? 'Flutter geliştiricisi ve yetişkin'
                : 'Flutter geliştiricisi ve genç';
            break;

          case Team.androidDevelopmentTeam:
            debugString = member.age > 24
                ? 'Android geliştiricisi ve yetişkin'
                : 'Android geliştiricisi ve genç';
            break;

          case Team.iOSDevelopmentTeam:
            debugString = member.age > 24
                ? 'iOS geliştiricisi ve yetişkin'
                : 'iOS geliştiricisi ve genç';
            break;

          case Team.uiUxDesignTeam:
            debugString = member.age > 24
                ? 'UI & UX geliştiricisi ve yetişkin'
                : 'UI & UX geliştiricisi ve genç';
            break;
        }
      });
    } catch (e) {
      setState(() {
        debugString = "Üye bulunamadı";
      });
    }
  }

  // Create a function that takes a team as an input and returns an array of the
  // contact information of all members in that team.

  // Flutter Developer takımının contact ınfo listesi
  List<ContactInformationModel> bringContactInfos(Team f_team) {
    var contactInfoList = neonAcademyMembers
        .where((element) => element.team == f_team)
        .map((e) => e.contact)
        .toList();

    return contactInfoList;
  }

  // Create a function that takes a team as an input and calculates the average age of the members in that team.

  void averageAge(Team f_team) {
    List<int> ageList = neonAcademyMembers
        .where((element) => element.team == f_team)
        .map((e) => e.age)
        .toList();

    int sum = ageList.reduce((value, element) => value + element);

    setState(() {
      sum ~/= ageList.length;
      debugString = 'Yaş ortalaması';
      debugInteger = sum;
    });
  }

  /* Create a switch statement that gives a promotion to a member based on their team.
  For example, if a member is in the Flutter Development Team, the function could
  promote them to "Senior Flutter Developer" and if the member is in the UI/UX Design Team,
  the function could promote them to "Lead Designer". */

  void promote(String fcontroller) {
    NeonAcademyMemberModel member = neonAcademyMembers.firstWhere(
      (element) => element.fullName.toLowerCase() == fcontroller.toLowerCase(),
    );

    if (member.fullName.isNotEmpty) {
      switch (member.team) {
        case Team.flutterDevelopmentTeam:
          member.title = 'Senior Flutter Developer';
          setState(() {
            debugString = 'Senior Flutter Developer';
          });
          break;
        case Team.iOSDevelopmentTeam:
          member.title = 'Senior iOS Developer';
          setState(() {
            debugString = 'Senior iOS Developer';
          });
          break;
        case Team.androidDevelopmentTeam:
          member.title = 'Senior Android Developer';
          setState(() {
            debugString = 'Senior Android Developer';
          });
          break;
        case Team.uiUxDesignTeam:
          member.title = 'Lead Designer';
          setState(() {
            debugString = 'Lead Designer';
          });
          break;
        default:
          debugString = "Bu kullanıcı hiçbir takımda yok";
          break;
      }
    }
  }

  /* Create a function that takes an age as an input and prints out the full names of
  all members that are older than that age and belong to a specific team
  (Flutter Development Team for example)
  */

  void olderOnes(int f_age, Team teamType) {
    setState(() {
      var olderOnes = neonAcademyMembers.where(
        (element) => element.age > f_age && element.team == teamType,
      );
      debugString = '';

      for (var element in olderOnes) {
        debugString += '\n';
        debugString += element.fullName;
      }
    });
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
                      getFlutterTeamMembers();
                    }, 'Flutter takımının üyelerinin bilgilerini yazdır'),

                    myButton(() {
                      makeDictionary();
                    }, 'Dictionary oluştur ve UI/UX sayısını yazdır'),

                    myButton(() {
                      getFlutterDevs(Team.androidDevelopmentTeam);
                    }, 'Flutter takımının üyelerinin adlarını yazdır'),

                    myButton(() {
                      makeSwitchDialog();
                    }, 'Kullanıcı adı gir ve takımını öğren'),

                    myButton(() {
                      promote("Zeynep Dandin");
                    }, 'Zeynep Dandin kişisini terfi yap'),

                    myButton(
                      () {
                        olderOnes(22, Team.flutterDevelopmentTeam);
                      },
                      'Flutter takımındakilerden 22 yaşından büyük olanları yazdır',
                    ),

                    myButton(() {
                      averageAge(Team.flutterDevelopmentTeam);
                    }, 'Flutter Developer Takımının yaş ortalaması'),

                    myButton(() {
                      message();
                    }, 'Takıma göre mesaj yazdır'),

                    myButton(() {
                      seniorityLevel('Zeynep Dandin');
                    }, 'Zeynep Dandin kişisinin takım ve yaş bilgisini yazdır'),
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
  ElevatedButton myButton(VoidCallback func, String text) {
    return ElevatedButton(
      onPressed: func,
      child: Text(text, style: TextStyle(color: Colors.red)),
    );
  }
}
