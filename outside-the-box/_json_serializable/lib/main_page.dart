import 'dart:convert'; // jsonEncode ve jsonDecode fonksiyonları bu kütüphanede bulunur

import 'package:_json_serializable/user.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    // JSON String
    String jsonString = '{"name": "Alice", "age": 25}';

    // ! JSON -> DART NESNESİ
    // DECODE
    Map<String, dynamic> jsonMap1 = jsonDecode(jsonString);

    // DESERIALIZATION
    User user = User.fromJson(jsonMap1);

    // ! DART NESNESİ -> JSON
    // SERIALIZATION
    Map<String, dynamic> jsonMap2 = user.toJson();
    
    // ENCODE
    String serializedUser = jsonEncode(jsonMap2);

    print(user.name);
    print(user.age);

    return Scaffold(
      appBar: AppBar(
        title: Text('Json Serializable', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [Text('test')]),
    );
  }
}
