import 'package:flutter/material.dart';

class SwitchView extends StatefulWidget {
  const SwitchView({super.key});

  @override
  State<SwitchView> createState() => _SwitchViewState();
}

// https://api.flutter.dev/flutter/material/Switch-class.html
class _SwitchViewState extends State<SwitchView> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light ? Colors.green : Colors.red,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 48),
              Text('Test'),

              Switch(
                value: light,
                thumbColor: const WidgetStatePropertyAll(Colors.black),
                activeThumbColor: Colors.red,
                inactiveThumbColor: Colors.green,
                onChanged: (bool value) {
                  setState(() {
                    light = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
