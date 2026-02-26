import 'package:comedy_club_challenge/comedy_club_challenge_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ComedyClubChallengeView(),
    );
  }
}