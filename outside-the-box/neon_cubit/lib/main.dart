import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_counter/app.dart';
import 'package:flutter_counter/counter_observer.dart';

void main() {
  // Sisteme observerimizi tanımladık
  Bloc.observer = const CounterObserver();
  runApp(const CounterApp());
}