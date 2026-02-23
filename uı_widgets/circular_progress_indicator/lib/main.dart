import 'package:circular_progress_indicator/circular_progress_indicator_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CircularProgressIndicatorView(),
    );
  }
}