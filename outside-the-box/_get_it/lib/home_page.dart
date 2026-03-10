import 'package:_get_it/get_it_service.dart';
import 'package:_get_it/user_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = sl<UserService>();
    return Scaffold(
      appBar: AppBar(
        title: Text('GetIt', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('AD SOYAD: ${userService.getUserName()}'),
          ),
        ],
      ),
    );
  }
}
