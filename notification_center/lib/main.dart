import 'package:flutter/material.dart';
import 'package:notification_center/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Geri Sayım Aracı',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const OnboardingScreen(),
    );
  }
}
