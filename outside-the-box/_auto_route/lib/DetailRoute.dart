import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DetailRoute extends StatelessWidget {
  const DetailRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailPage', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('TEST'),
      )]),
    );
  }
}
