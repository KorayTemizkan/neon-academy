class AsgardianModel {
  final int id;
  final String name;
  final String surname;
  final int age;
  final String email;

  const AsgardianModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.email,
  });

  // Bir Dart nesnesini sözlük haline dönüştürdük
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'age': age,
      'email': email,
    };
  }

  // SQL'den gelen veriyi dart nesnesine çevirir
  factory AsgardianModel.fromMap(Map<String, dynamic> map) {
    return AsgardianModel(
      id: map['id'] as int,
      name: map['name'] as String,
      surname: map['surname'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
    );
  }

  // Yazdırmak kolay olsun diye böyle yaptık
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, surname: $surname, age: $age, email: $email}';
  }
}
