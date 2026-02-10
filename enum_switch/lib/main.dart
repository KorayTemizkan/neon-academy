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

  /* Create a dictionary that contains the number of members in each team, and print out the number of members in the UI/UX Design Team. */

  Future<void> makeDictionary() async {
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
      debugString = 'Toplam sayı';

      debugInteger =
          countMembersTeams[Team.uiUxDesignTeam] ??
          177; // mapten gelen nullabledır. sen sıfır ile derleyiciye güvence vermelisin.
    });
  }

  Future<void> getFlutterTeamMembers() async {
    setState(() {
      backUp = neonAcademyMembers
          .where((element) => element.team == Team.flutterDevelopmentTeam)
          .toList();

      neonAcademyMembers = backUp;
    });
  }

  // Create a function that takes a team as an input and prints out the full names of all members in that team.
  // FLutter DEveleoper enumunu alıp bu takımdakilerin adlarını yazdıracak

  Future<void> getFlutterDevs(Enum f_team) async {
    var names = neonAcademyMembers
        .where((element) => element.team == f_team)
        .toList();

    setState(() {
      debugString += names.map((e) => e.fullName).toString();
    });
  }

  /* Create a switch statement that performs different actions based on the team of a member.
  For example, if a member is in the Flutter Development Team, the function could print out
  "This member is a skilled Flutter developer", and if the member is in the UI/UX Design Team, 
  the function could print out "This member is a talented designer". */

  Future<String> makeSwitch(String fcontroller) async {
    NeonAcademyMemberModel member = neonAcademyMembers.firstWhere(
      (element) => element.fullName.toLowerCase() == fcontroller.toLowerCase(),
    );

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

    return 'Nabers';
  }

  // Create a switch statement that prints out a different message for each team,
  //such as "The Flutter Development Team is the backbone of our academy" for the
  //Flutter Development Team and "The UI/UX Design Team is the face of our academy"
  //for the UI/UX Design Team.

  Future<void> message() async {
    setState(() {
      // switch tek bir enum değer üzerinde çalışıyor
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

  Future<void> seniorityLevel(String fcontroller) async {
    NeonAcademyMemberModel member = neonAcademyMembers.firstWhere(
      (element) => element.fullName.toLowerCase() == fcontroller.toLowerCase(),
    );

    setState(() {
      if (member.fullName.isNotEmpty) {
        for (var element in Team.values) {
          switch (element) {
            // switch case'lerine sadece tek bir şart koyabilirsin
            case Team.androidDevelopmentTeam:
              if (member.age > 24) {
                debugString = 'Android geliştiricisi ve yetişkin';
              }
              debugString = 'Android geliştiricisi ve genç';
              break;
            case Team.flutterDevelopmentTeam:
              if (member.age > 24) {
                debugString = 'Flutter geliştiricisi ve yetişkin';
              }
              debugString = 'Flutter geliştiricisi ve genç';
              break;
            case Team.iOSDevelopmentTeam:
              if (member.age > 24) {
                debugString = 'iOS geliştiricisi ve yetişkin';
              }
              debugString = 'iOS geliştiricisi ve genç';
              break;
            case Team.uiUxDesignTeam:
              if (member.age > 24) {
                debugString = 'UI & UX geliştiricisi ve yetişkin';
              }
              debugString = 'UI & UX geliştiricisi ve genç';
              break;
            default:
              debugString = 'Test';
          }
        }
      }
    });
  }

  // Create a function that takes a team as an input and returns an array of the
  // contact information of all members in that team.

  // Flutter Developer takımının contact ınfo listesi
  Future<List<ContactInformationModel>> bringContactInfos(Team f_team) async {
    var contactInfoList = neonAcademyMembers
        .where((element) => element.team == f_team)
        .map((e) => e.contact)
        .toList();

    return contactInfoList;
  }

  // Create a function that takes a team as an input and calculates the average age of the members in that team.

  Future<void> averageAge(Team f_team) async {
    List<int> ageList = neonAcademyMembers
        .where((element) => element.team == f_team)
        .map((e) => e.age)
        .toList();

    int sum = ageList.reduce((value, element) => value + element);

    setState(() {
      sum ~/= ageList.length;
      debugInteger = sum;
    });
  }

  /* Create a switch statement that gives a promotion to a member based on their team.
  For example, if a member is in the Flutter Development Team, the function could
  promote them to "Senior Flutter Developer" and if the member is in the UI/UX Design Team,
  the function could promote them to "Lead Designer". */

  Future<void> promote(String fcontroller) async {
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

  Future<void> olderOnes(int f_age, Team teamType) async {
    setState(() {
      var olderOnes = neonAcademyMembers.where(
        (element) => element.age > f_age && element.team == teamType,
      );

      for (var element in olderOnes) {
        debugString += '\n';
        debugString += element.fullName;
      }
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
              margin: const EdgeInsets.all(16),
              elevation: 1,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    ElevatedButton(
                      onPressed: () {
                        getFlutterTeamMembers();
                      },
                      child: Text(
                        'Flutter takımının üyelerinin adlarını yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        makeDictionary();
                      },
                      child: Text(
                        'Dictionary oluştur ve UI/UX sayısını yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        getFlutterDevs(Team.androidDevelopmentTeam);
                      },
                      child: Text(
                        'Flutter takımının üyelerinin adlarını yazdır',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                    TextField(controller: _questionController),

                    ElevatedButton(
                      onPressed: () {
                        makeSwitch(_questionController.text);
                      },

                      child: Column(
                        children: [
                          Text(
                            'Kullanıcı adı gir ve takımını öğren',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        promote(_questionController.text);
                      },

                      child: Column(
                        children: [
                          Text(
                            'Terfi yap',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        olderOnes(22, Team.flutterDevelopmentTeam);
                      },

                      child: Column(
                        children: [
                          Text(
                            'Yaşa ve takıma göre yazdır',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        averageAge(Team.flutterDevelopmentTeam);
                      },

                      child: Column(
                        children: [
                          Text(
                            'Flutter Developer Takımının yaş ortalaması',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        message();
                      },

                      child: Column(
                        children: [
                          Text(
                            'Takıma göre mesaj yazdır',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        seniorityLevel(_questionController.text);
                      },

                      child: Column(
                        children: [
                          Text(
                            'Takım ve yaş bilgisini yazdır',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
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
}
