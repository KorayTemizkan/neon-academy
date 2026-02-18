import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp/sp.dart';

// Kendi projemde de Hive + SP kullanıyorum. Oradan tanışıklığım vardı hızlıca yaptım
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

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _visitCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(height: 50),

              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'Ad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  context.read<Sp>().setFirstName(_firstNameController.text);
                },
                child: Text('Kaydet'),
              ),
              SizedBox(height: 20),

              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Soyad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<Sp>().setLastName(_lastNameController.text);
                },
                child: Text('Kaydet'),
              ),
              SizedBox(height: 20),

              TextField(
                controller: _visitCountController,
                decoration: InputDecoration(
                  labelText: 'Gidilen Ülke Sayısı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  int? num = int.tryParse(_visitCountController.text);

                  if (num != null) {
                    context.read<Sp>().setVisitCount(
                      int.parse(_visitCountController.text),
                    );
                  }
                },
                child: Text('Kaydet'),
              ),
              SizedBox(height: 20),
              Divider(height: 2, color: Colors.purple),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  context.read<Sp>().setBeenAbroad(true);
                },
                child: Text('ABD\'ye gittim'),
              ),

              ElevatedButton(
                onPressed: () {
                  context.read<Sp>().setBeenAbroad(false);
                },
                child: Text('ABD\'ye gitmedim'),
              ),

              SizedBox(height: 20),
              Divider(height: 2, color: Colors.purple),
              SizedBox(height: 20),

              Consumer<Sp>(
                builder: (context, sp, child) => Card(
                  child: Column(
                    children: [
                      Text('Ad: ${sp.firstName}'),
                      Text('Soyad: ${sp.lastName}'),
                      Text('Gidilen Ülke Sayısı: ${sp.visitCount}'),
                      Text('Abd\'ye gittin mi?: ${sp.beenAbroad}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
