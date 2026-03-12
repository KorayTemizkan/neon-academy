import 'package:_hero/order.dart';
import 'package:_hero/pages/cover_down_page.dart';
import 'package:_hero/my_transitions.dart';
import 'package:_hero/pages/slide_up_page.dart';
import 'package:_hero/pages/standart_page.dart';
import 'package:_hero/pages/zoom_slide_page.dart';
import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  Order myOrder = Order();

  MyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        _buildMazeButton(
          context: context,
          label: 'Up (Slide)',
          icon: Icons.arrow_upward,
          route: MyTransitions.slideUp(const SlideUpPage()),
        ),

        const SizedBox(height: 8),
        _buildMazeButton(
          context: context,
          label: 'Right (Zoom)',
          icon: Icons.arrow_forward,
          route: MyTransitions.zoomSlide(const ZoomSlidePage()),
        ),

        const SizedBox(height: 8),

        _buildMazeButton(
          context: context,
          label: 'Left (Push)',
          icon: Icons.arrow_back,
          route: MaterialPageRoute(builder: (context) => const StandartPage()),
        ),

        const SizedBox(height: 8),

        _buildMazeButton(
          context: context,
          label: 'Down (Cover)',
          icon: Icons.arrow_downward,
          route: MyTransitions.coverDown(const CoverDownPage()),
        ),
      ],
    );
  }

  // MODÜLER BUTON METODU
  Widget _buildMazeButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Route route,
  }) {
    return SizedBox(
      width: 192, // Tüm butonların aynı genişlikte olması için
      child: ElevatedButton.icon(
        onPressed: () {
          if (myOrder.orderIndex > 6) {
            return;
          }
          if (myOrder.myOrder[myOrder.orderIndex] != label) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You\'re trapped, try again!')),
            );
          } else {
            if (myOrder.orderIndex != 7) {
              myOrder.increaseIndex();
            }
            Navigator.push(context, route);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Congratulations, you did it!')),
            );
          }
        },
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
