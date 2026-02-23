import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressIndicatorView extends StatefulWidget {
  const CircularProgressIndicatorView({super.key});

  @override
  State<CircularProgressIndicatorView> createState() =>
      _CircularProgressIndicatorViewState();
}

class _CircularProgressIndicatorViewState
    extends State<CircularProgressIndicatorView> {
  double myNum = 0;
  bool isCircularActive = false;
  Color myColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 48),

            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isCircularActive = true;
                  myNum = 0;
                  myColor = Colors.red;
                });

                for (var i = 0; i < 100; i++) {
                  await Future.delayed(
                    const Duration(milliseconds: 100),
                    () {},
                  );

                  setState(() {
                    myNum++;
                  });

                  if (myNum % 10 == 0) {
                    setState(() {
                      // Bu formül RGB üretir. yani başına 0xFF koymaz. withOpacity ile bunu eklemiş oluyoruz. %100 görünürlük. GEMİNİ
                      myColor = Color(
                        (Random().nextDouble() * 0xFFFFFF).toInt(),
                      ).withOpacity(1.0);
                    });
                  }
                }

                setState(() {
                  isCircularActive = false;
                });
              },
              child: const Text('Sıfırla ve Başlat'),
            ),

            SizedBox(height: 16),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isCircularActive) ...[
                    // Burada value eklemezsen sürekli döner, myNum/100 yaparak çemberin ne kadarının dolu olacağını ayarladık
                    CircularProgressIndicator(
                      value: myNum / 100,
                      color: myColor,
                    ),
                  ],
                  SizedBox(width: 24),
                  Text('$myNum'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
