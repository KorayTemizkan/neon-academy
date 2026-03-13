import 'package:_auto_route/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              // pushRoute auto_route'un bir fonksiyonu, normallerle karıştırma
              onPressed: () => context.pushRoute(const DetailRoute()),
              child: Text('DetailPage'),
            ),
          ),
        ],
      ),
    );
  }
}
