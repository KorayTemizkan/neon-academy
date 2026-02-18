import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notification_center/decrypter.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  String displayMessage = "Deşifre bekleniyor...";
  StreamSubscription? _subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Burada yayın açılıyor
    _subscription = NotificationCenter.onMessageReceived.listen((event) {
      setState(() {
        displayMessage = event;
      });
    });
    
    // Zaman kısıtı
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(displayMessage)));
  }
}
