class ContactInformationModel {
  String email;
  String phoneNumber;

  ContactInformationModel({required this.email, required this.phoneNumber});

   factory ContactInformationModel.fromMap(Map<String, dynamic> map) {
    return ContactInformationModel(
      email: map["email"] ?? "",
      phoneNumber: map["phoneNumber"] ?? "",
    );
  }
}
