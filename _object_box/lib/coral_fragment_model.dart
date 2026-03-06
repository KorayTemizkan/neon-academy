import 'package:objectbox/objectbox.dart';

@Entity()
class CoralFragmentModel {
  @Id() // Burada bunu otomatik olarak 1,2,3 diye arttırırız
  int id = 0;

  @Index() // Arama yaparken hızlanması için başlığa indeks atıyoruz
  String title;

  String species;
  String content;

  @Property(type: PropertyType.date) // Tarih formatında saklanacağını belirtir
  DateTime fragmentDate;

  bool isAncient;

  CoralFragmentModel({
    this.id = 0,
    required this.title,
    required this.species,
    required this.content,
    required this.fragmentDate,
    this.isAncient = false,
  });
}
