import 'package:_get_it/get_it_service.dart';
import 'package:_get_it/user_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Stateless widget olunca servisi doğruca değişken gibi widget üstünde tanımlayabiliriz
  // Ama tabii ki bir state management yöntemiyle ve clean architecture mimarisiyle başka yapılıyor. Burası en basit test ortamı.
  final userService = sl<UserService>();

  @override
  Widget build(BuildContext context) {
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
