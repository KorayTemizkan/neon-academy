import 'package:flutter/material.dart';

class Plane extends StatelessWidget {
  const Plane({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Hero(
        tag: 'maze-airplane',
        child: Icon(Icons.local_airport, size: 192, color: Colors.white),
      ),
    );
  }
}
