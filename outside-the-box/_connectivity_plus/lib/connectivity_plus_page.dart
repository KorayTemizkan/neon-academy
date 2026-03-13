import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectivityPlusPage extends StatefulWidget {
  const ConnectivityPlusPage({super.key});

  @override
  State<ConnectivityPlusPage> createState() => _ConnectivityPlusPageState();
}

class _ConnectivityPlusPageState extends State<ConnectivityPlusPage> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  String debug = 'test';

  Future<void> showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Uyarı!'),
          content: const Text('İnternet bağlantısı kesildi!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // Sağ tıkla -> go to definition -> enum içinde tipleri görebilirsin
    // bluetooth, wifi, ethernet, mobile, vpn(biraz değişik), other, none
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      if (result.contains(ConnectivityResult.wifi)) {
        setState(() {
          debug = 'wifi-ye bağlı';
        });
      } else if (result.contains(ConnectivityResult.none)) {
        setState(() {
          debug = 'wifi-ye bağlı değil';
        });
        showMyDialog();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Plus', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: Column(children: [Text(debug)]),
    );
  }
}
