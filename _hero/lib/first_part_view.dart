import 'package:flutter/material.dart';

class FirstPartView extends StatelessWidget {
  const FirstPartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Part', style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,),
      body: Column(
        children: [

          SizedBox(height: 16),

          Center(
            child: Hero(
              
              tag: 'maze-airplane',
              child: Icon(Icons.local_airport, size: 192),
            ),
          ),
        ],
      ),
    );
  }
}