import 'package:flutter/material.dart';
import 'package:lineer_progress_indicator/lineer_progress_indicator_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LineerProgressIndicatorView(),
    );
  }
}