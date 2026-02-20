import 'package:flutter/material.dart';

enum Calendar { day, week, month }

// https://api.flutter.dev/flutter/material/SegmentedButton-class.html
class MySegmentedButton extends StatefulWidget {
  const MySegmentedButton({super.key});

  @override
  State<MySegmentedButton> createState() => _MySegmentedButtonState();
}

class _MySegmentedButtonState extends State<MySegmentedButton> {
  Calendar calendarView = Calendar.day;
  double myFontSize = 24;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: Colors.pinkAccent,
          backgroundColor: Colors.purpleAccent
        ),
        segments: <ButtonSegment<Calendar>>[
          ButtonSegment(
            value: Calendar.day,
          label: Text('Neon Academy 2023', style: TextStyle(fontSize: myFontSize)),
            icon: Icon(Icons.calculate),
          ),

          ButtonSegment(
            value: Calendar.week,
          label: Text('Neon', style: TextStyle(fontSize: myFontSize)),
            icon: Icon(Icons.abc_outlined),
          ),

          ButtonSegment(
  
            value: Calendar.month,
            label: Text('Apps', style: TextStyle(fontSize: myFontSize),),
            icon: Icon(Icons.abc),
          ),
        ],
        
        selected: <Calendar>{calendarView},
        onSelectionChanged: (Set<Calendar> newSelection) {
          setState(() {
            calendarView = newSelection.first;
          });

          if (newSelection.first == Calendar.day) {
            myFontSize = 24;
          } else if (newSelection.first == Calendar.week) {
            myFontSize = 18;
          } else if (newSelection.first == Calendar.month) {
            myFontSize = 12;
          }
        },
      
    );
  }
}
