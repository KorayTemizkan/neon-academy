import 'package:_hero/first_part_view.dart';
import 'package:flutter/material.dart';

class HeroView extends StatefulWidget {
  const HeroView({super.key});

  @override
  State<HeroView> createState() => _HeroViewState();
}

class _HeroViewState extends State<HeroView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(textAlign: TextAlign.center,style: TextStyle(fontSize: 24),
                    'Welcome to the maze. If you succeed, you are ready for the real world?',
                  ),
                  SizedBox(height: 16),

                  Hero(
                    tag: 'maze-airplane',
                    child: Icon(Icons.local_airport, size: 96),
                  ),

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FirstPartView(),
                        ),
                      );
                    },
                    child: Text('NEXT', style: TextStyle(color: Colors.red),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
