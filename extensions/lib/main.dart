import 'package:extensions/boolean_extensions.dart';
import 'package:extensions/date_time_extensions.dart';
import 'package:extensions/integer_extensions.dart';
import 'package:extensions/map_extensions.dart';
import 'package:extensions/map_model.dart';
import 'package:extensions/set_extensions.dart';
import 'package:extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController pallindromController = TextEditingController();
  TextEditingController primeController = TextEditingController();
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
      body: Column(
        children: [
          SizedBox(height: 50),
          TextField(controller: pallindromController),

          Text('Palindrom Kontrolü'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                debug = pallindromController.text.isPallindrom();
              });
            },
            child: Text('Sonuç: $debug'),
          ),

          TextField(
            controller: primeController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),

          Text('Asal Sayı Kontrolü'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                int? num = int.parse(primeController.text);
                debug = num.isPrime();
              });
            },
            child: Text('Sonuç: $debug'),
          ),

          Text('Tarih Farkı Kontrolü'),
          ElevatedButton(
            onPressed: () async {
              firstDate = await _pickDate(context);
              secondDate = await _pickDate(context);

              setState(() {
                var test = secondDate?.calculateRemainingDays(firstDate!);

                debug = test.toString();
              });
            },
            child: Text('Sonuç: $debug'),
          ),

          // Bool extension
          ElevatedButton(
            onPressed: () {
              setState(() {
                debug = kLetter.isThereKLetter();
              });
            },
            child: Text('Sonuç: $debug'),
          ),

          // Set extension
          ElevatedButton(
            onPressed: () {
              List<String> test = ['a', 'b', 'a'];
              setState(() {
                debug = test.toSet().uniques();
              });
            },
            child: Text('Sonuç: $debug'),
          ),

          // Map extension, burada biraz uğraşmak istedim o yüzden böyle bir yöntem seçtim yoksa ayrı model oluşturacaktım
          ElevatedButton(
            onPressed: () {
              List<MapModel> citizens = [
                MapModel(name: 'Koray', surname: 'Temizkan'),
                MapModel(name: 'Ahmet', surname: 'Yılmaz'),
                MapModel(name: 'Fidan', surname: 'Temizkan'),
              ];

              var censusMap = citizens.groupBySurname();
              print(censusMap);
            },
            child: Text('Sonuç: $debug'),
          ),
        ],
      ),
    );
  }
}
