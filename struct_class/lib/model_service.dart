import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:struct_class/models/neon_academy_member_model.dart';

Future<List<NeonAcademyMemberModel>> fetchNeonAcademyMembers() async {
  final String loadedJson = await rootBundle.loadString(
    'lib/neon_academy_members.json',
  );
  final List<dynamic> decodedJson = jsonDecode(loadedJson);

  return decodedJson
      .map((item) => NeonAcademyMemberModel.fromMap(item))
      .toList();
}
