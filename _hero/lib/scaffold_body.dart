import 'package:_hero/my_buttons.dart';
import 'package:_hero/plane.dart';
import 'package:flutter/material.dart';

class ScaffoldBody extends StatelessWidget {
  const ScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          // Buraya kendi labirent görselinin linkini yapıştır
          image: NetworkImage(
            'https://w0.peakpx.com/wallpaper/865/349/HD-wallpaper-colorful-maze-background.jpg',
          ),
          fit: BoxFit.cover, // Ekranı boşluk kalmayacak şekilde doldurur
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 48),
          Plane(),
          const Spacer(),
          MyButtons(), // Butonların burada
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
