import 'package:_hive/hive_view.dart';
import 'package:_hive/task_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); // Veritabanının telefonda nereye kaydedileceğini ayarladık
  Hive.registerAdapter(
    TaskModelAdapter(),
  ); // Özel veri türümüzü Hive'e tanımladık
  await Hive.openBox<TaskModel>('tasks'); // Kutumuzu hazırladık
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /*
  late Box<TaskModel>('tasks')
  const MyApp({super.key});
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HiveView());
  }
}
