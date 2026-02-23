import 'package:flutter/material.dart';

class LineerProgressIndicatorView extends StatefulWidget {
  const LineerProgressIndicatorView({super.key});

  @override
  State<LineerProgressIndicatorView> createState() =>
      _LineerProgressIndicatorViewState();
}

class _LineerProgressIndicatorViewState
    extends State<LineerProgressIndicatorView> {
  int myNum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 48),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  myNum++;
                });

                if (myNum == 10) {
                  setState(() {
                    myNum = 0;
                  });
                }
              },
              child: Text('1 arttır'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  myNum = 0;
                });
              },
              child: Text('Sıfırla'),
            ),

            Row(
              children: [
                SizedBox(width: 8),

                Text('0'),

                SizedBox(width: 8),

                Expanded(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.blue,
                    value: myNum/10, // mesela 7 sayısını 0.7 yaptık. Böylece double alan value değerine atayabildik
                  ),
                ),
                SizedBox(width: 8),

                Text('10'),
                SizedBox(width: 8),

              ],
            ),

            Text('$myNum', style: TextStyle(fontSize: 48)),
          ],
        ),
      ),
    );
  }
}
