import 'package:flutter/material.dart';
import 'package:flutter_counter/counter/counter.dart';

// Uygulamanın giriş kapısı. Kök widget
class CounterApp extends MaterialApp {
  const CounterApp({super.key}) : super(home: const CounterPage());
}
