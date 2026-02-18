import 'package:extensions/boolean_extensions.dart';
import 'package:extensions/date_time_extensions.dart';
import 'package:extensions/integer_extensions.dart';
import 'package:extensions/map_extensions.dart';
import 'package:extensions/map_model.dart';
import 'package:extensions/set_extensions.dart';
import 'package:extensions/string_extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController myController = TextEditingController();
  bool kLetter = false;
  DateTime? firstDate;
  DateTime? secondDate;

  String debug = '';

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2027),
      initialDate: DateTime.now(),
    );

    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 50),
        
            TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: 'Metin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
        
            Text('Palindrom Kontrolü'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  debug = myController.text.isPallindrom();
                });
              },
              child: Text('Sonuç: $debug'),
            ),
        
            SizedBox(height: 15),
        
            Text('Asal Sayı Kontrolü'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  int? num = int.tryParse(myController.text);
        
                  if (num != null) {
                    debug = num.isPrime();
                  } else {
                    debug = 'Sayı giriniz!';
                  }
                });
              },
              child: Text('Sonuç: $debug'),
            ),
        
            SizedBox(height: 15),
        
            Text('Tarih Farkı Kontrolü'),
            ElevatedButton(
              onPressed: () async {
                firstDate = await _pickDate(context);
                secondDate = await _pickDate(context);
        
                if (firstDate != null && secondDate != null) {
                  setState(() {
                    var test = secondDate?.calculateRemainingDays(firstDate!);
        
                    debug = test.toString();
                  });
                }
              },
              child: Text('Sonuç: $debug'),
            ),
        
            SizedBox(height: 15),
        
            // Bool extension
            Text('K harfi var mı kontrolü'),
            ElevatedButton(
              onPressed: () {
                if (myController.text.contains('k')) {
                  kLetter = true;
                } else {
                  kLetter = false;
                }
                setState(() {
                  debug = kLetter.isThereKLetter();
                });
              },
              child: Text('Sonuç: $debug'),
            ),
        
            Divider(height: 40, color: Colors.lightBlue),
        
            // Set extension
            Text('a,b,a listesinden benzersiz olanlar Kontrolü'),
            ElevatedButton(
              onPressed: () {
                List<String> test = ['a', 'b', 'a'];
                setState(() {
                  debug = test.toSet().uniques();
                });
              },
              child: Text('Sonuç: $debug'),
            ),
        
            SizedBox(height: 15),
        
            Text('3 kişiden aynı soyadlıları listelemek'),
            ElevatedButton(
              onPressed: () {
                List<MapModel> citizens = [
                  MapModel(name: 'Koray', surname: 'Temizkan'),
                  MapModel(name: 'Ahmet', surname: 'Yılmaz'),
                  MapModel(name: 'Fidan', surname: 'Temizkan'),
                ];
        
                var censusMap = citizens.groupBySurname();
                print(censusMap);
                setState(() {
                  debug = censusMap.toString();
                });
              },
              child: Text('Sonuç: $debug'),
            ),
          ],
        ),
      ),
    );
  }
}
