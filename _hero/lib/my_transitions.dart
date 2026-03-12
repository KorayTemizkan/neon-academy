import 'package:flutter/material.dart';

// Yani bu kullanımı ezberlemekten başka çarem yok.

class MyTransitions {
  // UP: Slide -> Aşağıdan yukarı
  static Route slideUp(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(0, 1), end: Offset.zero),
          ),
          child: child,
        );
      },
    );
  }

  // RIGHT: ZoomSlide -> Hem büyüme hem yana kayma
  static Route zoomSlide(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation.drive(Tween(begin: 0.0, end: 1.0)),
          child: child,
        );
      },
    );
  }

  // Cover (Yukarıdan aşağı inen örtü gibi)
  static Route coverDown(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(0, -1), end: Offset.zero),
          ),
          child: child,
        );
      },
    );
  }
}
