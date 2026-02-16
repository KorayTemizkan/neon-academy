import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp/sp.dart';

// context.watch ile build içinde tekrar çizdiririz, fonksiyon gibi tek kullanımlıklarda read kullan
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final spProvider = Sp();
  await spProvider.init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: spProvider)],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*They input the information using creative prompts such as
  "Have you been to this place before?" for the Bool value, 
  "How many times have you visited this place?" for the Integer value,
  and "What is the name of the place you want to visit?" for the String value.*/

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _visitCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50),
            Text('Test'),

            TextField(controller: _firstNameController),
            ElevatedButton(
              onPressed: () {
                context.read<Sp>().setFirstName(_firstNameController.text);
              },
              child: Text('Ad'),
            ),

            TextField(controller: _lastNameController),
            ElevatedButton(
              onPressed: () {
                context.read<Sp>().setLastName(_lastNameController.text);
              },
              child: Text('Soyad'),
            ),

            TextField(controller: _visitCountController),
            ElevatedButton(
              onPressed: () {
                context.read<Sp>().setVisitCount(
                  int.parse(_visitCountController.text),
                );
              },
              child: Text('Gidilen Ülke Sayısı'),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<Sp>().setBeenABroad(true);
              },
              child: Text('ABD-ye gittim'),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<Sp>().setBeenABroad(false);
              },
              child: Text('ABD-ye gitmedim'),
            ),

            Consumer<Sp>(
              builder: (context, sp, child) => Card(
                child: Column(
                  children: [
                    Text('Ad: ${sp.firstName}'),
                    Text('Soyad: ${sp.lastName}'),
                    Text('Sayı: ${sp.visitCount}'),
                    Text('Bool: ${sp.beenAbroad}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
