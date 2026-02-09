import 'package:struct_class/models/contact_information_model.dart';

class NeonAcademyMemberModel {
  String fullName; // AD
  String title; // Unvan
  String horoscope; // Burç
  String memberLevel; // A1, A2, C1 gibi harf+sayı yerine çözümüm
  String homeTown; // Memleket
  int age;
  ContactInformationModel contact;

  NeonAcademyMemberModel({
    required this.fullName,
    required this.title,
    required this.horoscope,
    required this.memberLevel,
    required this.homeTown,
    required this.age,
    required this.contact,
  });

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
