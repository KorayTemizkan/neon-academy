import 'package:data_table/passenger_model.dart';
import 'package:flutter/material.dart';

class PassengerView extends StatelessWidget {
  PassengerModel passenger;

  PassengerView({super.key, required this.passenger});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 48),
            Card(
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text('YOLCU BİLGİLERİ:\n'),
                    Text('${passenger.name}'),
                    Text('${passenger.surname}'),
                    Text('${passenger.team}'),
                    Text('${passenger.age}'),
                    Text('${passenger.hometown}'),
                    Text('${passenger.mail}'),
                  ],
                ),
              ),
            ),

            ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text('Geri Dön')),
          ],
        ),
      ),
    );
  }
}
