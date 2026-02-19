import 'package:flutter/material.dart';
import 'package:textfield/textfield_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const TextfieldView());
  }
}
