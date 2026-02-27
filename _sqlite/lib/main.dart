import 'package:_sqlite/database_provider.dart';
import 'package:_sqlite/sqlite_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Daha önce bu konuyu Tığcık'ta yaptığım için oradan yardım alarak bu görevi bitirdim. Bkz -> GitHub hesabım.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => DatabaseProvider()..init(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SqliteView());
  }
}
