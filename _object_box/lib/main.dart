import 'package:_object_box/object_box_handler.dart';
import 'package:_object_box/object_box_view.dart';
import 'package:flutter/material.dart';

// Uygulamanın her yerinden erişmemiz için küresel bir anahtar
late ObjectBoxHandler objectBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBoxHandler.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const ObjectBoxView());
  }
}
