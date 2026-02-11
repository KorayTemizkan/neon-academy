import 'package:struct_class/models/contact_information_model.dart';

class NeonAcademyMemberModel {
  String fullName;                 // Ad
  String title;                    // Unvan
  String horoscope;                // Burç
  String memberLevel;              // A1, A2, C1 gibi harf+sayı yerine çözümüm
  String homeTown;                 // Memleket
  int age;                         // Yaş
  String? mentorLevel;             // null olabilir ekledik
  ContactInformationModel contact; // Diğer modelden çektik

  NeonAcademyMemberModel({
    required this.fullName,
    required this.title,
    required this.horoscope,
    required this.memberLevel,
    required this.homeTown,
    required this.age,
    required this.contact,
    this.mentorLevel,              // Opsiyonel çünkü isteğe bağlı ekliyoruz. JSON'dan çekmiyoruz
  });

  // JSON'dan gelen verilerin türü belirli olduğu için daha fazla atama güvenliği eklemedim. Bu kadarı yeterli.
  factory NeonAcademyMemberModel.fromMap(Map<String, dynamic> map) {
    return NeonAcademyMemberModel(
      fullName: map["fullName"] ?? "",
      title: map["title"] ?? "",
      horoscope: map["horoscope"] ?? "",
      memberLevel: map["memberLevel"] ?? "",
      homeTown: map["homeTown"] ?? "",
      age: map["age"] ?? 0,
      contact: ContactInformationModel.fromMap(map["contact"] ?? {}),
    );
  }
}
