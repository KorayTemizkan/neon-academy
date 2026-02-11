import 'package:struct_class/models/contact_information_model.dart';

enum Team {
  flutterDevelopmentTeam,
  iOSDevelopmentTeam,
  androidDevelopmentTeam,
  uiUxDesignTeam,
}

class NeonAcademyMemberModel {
  String fullName; // AD
  String title; // Unvan
  String horoscope; // Burç
  String memberLevel; // A1, A2, C1 gibi harf+sayı yerine çözümüm
  String homeTown; // Memleket
  int age;
  String? mentorLevel; // null olabilir ekledik
  ContactInformationModel contact;
  Team team;
  int?
  motivationLevel; // ? ile null olabileceğini garanti ediyoruz. Başlangıçta otomatik null atanıyor

  NeonAcademyMemberModel({
    required this.fullName,
    required this.title,
    required this.horoscope,
    required this.memberLevel,
    required this.homeTown,
    required this.age,
    required this.contact,
    this.mentorLevel,
    required this.team,
  });

  // JSON'dan dart nesnesine
  factory NeonAcademyMemberModel.fromMap(Map<String, dynamic> map) {
    return NeonAcademyMemberModel(
      fullName:
          map["fullName"] ??
          "", // {"fullName": "Zeynep" olduğu için key value ilişkisinden dolayı hep map kullandık}
      title: map["title"] ?? "",
      horoscope: map["horoscope"] ?? "",
      memberLevel: map["memberLevel"] ?? "",
      homeTown: map["homeTown"] ?? "",
      age: map["age"] ?? 0,
      contact: ContactInformationModel.fromMap(map["contact"] ?? {}),
      team: Team.values.firstWhere((element) => element.name == map["team"]),
    );
  }

  String get teamName {
    switch (team) {
      case Team.flutterDevelopmentTeam:
        return "Flutter Takımı";
      case Team.iOSDevelopmentTeam:
        return "iOS Takımı";
      case Team.androidDevelopmentTeam:
        return "Android Takımı";
      case Team.uiUxDesignTeam:
        return "UıUx Takımı";
    }
  }

  int increaseMotivation(int num) {
    if (motivationLevel == null) {
      motivationLevel = 1;
    } else {
      motivationLevel =
          motivationLevel! + num; // += kabul etmedi nullable olma yüzünden
    }

    return motivationLevel!;
  }
}
