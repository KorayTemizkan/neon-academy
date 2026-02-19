import 'package:flutter/material.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({super.key});

  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),

          Text('Sayaç : $count'),

          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  count++;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: BoxBorder.all(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.lightBlueAccent,
                ),
                alignment: Alignment.topCenter,
                height: 240,
                width: 240,
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Text('Konteynıra Tıkla'),
                    Text('Test 2'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Satır 1'), SizedBox(width: 5), Text('Satır 2')]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
