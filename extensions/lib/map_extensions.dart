import 'package:extensions/map_model.dart';

// Burada Gemini'den yardım aldım. Map kullanımında hala iyi değilim
extension MapExtensions on List<MapModel> {
  Map<String, List<MapModel>> groupBySurname() {
    Map<String, List<MapModel>> families = {};

    for (var element in this) {
      if (!families.containsKey(element.surname)) {
        families[element.surname] = [];
      }

      families[element.surname]!.add(element);
    }
    return families;
  }
}
