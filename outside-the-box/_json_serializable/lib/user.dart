// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});

  // Bunlar standart kalıp
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}


/*

Kaynak: https://medium.com/@ImAmmarYasser/understanding-json-serialization-and-deserialization-in-flutter-eb72d5c54ddb
Bu kaynakta bir sürü özellik var ihtiyacın olunca kullanırsın. Örneğin nullable, required vb.
! Açıklamalar

? Serialization:
* Bir Dart nesnesini kolayca aktarılabilecek bir veri formatına çevirmektir.
* Örneğin User sınıfındaki verileri Map<String, dynamic> yapısına dönüştürmek

? Encoding:
* Bu mapi kablolar üzerinden geçebilecek string yapısına çevirmek.
* Örneğin jsonEncode()

? Deserialization
* Map yapısını alıp Dart nesnesine çevirmek
* Örneğin fromJson()

? Decoding:
* Kablolar üzerinden gelen string yapısını alıp map haline çevirmek
* Örneğin jsonDecode()

? İki yöntem var
! Manual Serialization    -> Klasik kullandığın yöntem
! Automated Serialization -> json_serializable paketinin kullanıldığı yöntemmiş

İşler karmaşıklaşırsa, çok fazla property(özellik) varsa bu paketi kullanmak mantıklı
Ama projeden projeye manuel ya da automated seçeceksin

1)
dependencies:
  json_annotation: ^4.8.0

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.7.0

  eklemeyi unutma (sürümler değişebilir)

2) Yukarıdaki kalıp

3) dart run build_runner build --delete-conflicting-outputs

dart run build_runner watch --delete-conflicting-outputs -> böyle olursa sürekli dinliyor ve değişiklikte üretiyor

! BUILD RUNNER NEDİR?

Code generation işlemini otomatikleştiren bir araçtır. Bazı paketler yazman gereken yüzlerce satır karmaşık kodu sadece
birkaç etiket yardımıyla (JsonSerializable paketinde @JsonSerializable()) yazar. 

? Hata payını azaltır, vakit kazandırır, tip güvenliği sağlar
*/