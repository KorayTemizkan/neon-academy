import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertControllerView extends StatefulWidget {
  const AlertControllerView({super.key});

  @override
  State<AlertControllerView> createState() => _AlertControllerViewState();
}

class _AlertControllerViewState extends State<AlertControllerView> {
  String debug = '';
  final TextEditingController textEditingController = TextEditingController();
  
  // https://api.flutter.dev/flutter/material/AlertDialog-class.html
  // Gelen girdilere göre buton tasarlar.
  Future<void> _showMyDialog(
    String title,
    String content1,
    String content2,
    String button1,
    String button2,
    bool isCancel,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible:
          !isCancel, // Kullanıcı mutlaka butonlara basmalı, eğer olmazsa buton dışında bir yere basınca da kapanır
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(children: [Text(content1), Text(content2)]),
          ),
          actions: [
            if (isCancel) ...[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: Text(button1),
              ),
            ],

              TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: Text(button2),
            ),
          ],
        );
      },
    );
  }
  
  // https://api.flutter.dev/flutter/material/AlertDialog-class.html
  Future<void> _showMyDialogWithTextField() async {
    return showDialog(
      context: context,
      barrierDismissible:
          false, // kullanıcı butona basmalı derken neyi kast ediyor
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buton 3'),
          content: SingleChildScrollView(
            child: ListBody(children: [Text('Açıklama 1'), Text('Açıklama 2')]),
          ),

          actions: [
            TextField(controller: textEditingController),

            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text('Geri Dön'),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      debug = textEditingController.text;
                    });
                    Navigator.pop(context, 'OK');
                  },
                  child: Text('Devam Et'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  
  // https://api.flutter.dev/flutter/cupertino/CupertinoActionSheet-class.html
  // Burası iOS tarzı menüymüş. Ekranın altından yukarı doğru çıkar, bottomSheet gibi düşün
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Dosya Menüsü'),
        message: const Text('Dosya işlemleri menüsüne hoş geldiniz'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true, 
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Paylaş'),
          ),

          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Düzenle'),
          ),

          CupertinoActionSheetAction(
            isDestructiveAction: true, 
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 48),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'BUTONLAR',
                    style: TextStyle(color: Colors.red, fontSize: 48),
                  ),
                  Text('TextField Değeri: $debug'),
                  ElevatedButton(
                    onPressed: () async {
                      await _showMyDialog(
                        'Buton 1',
                        'Açıklama 1',
                        'Açıklama 2',
                        'Geri Dön',
                        'Devam Et',
                        false,
                      );
                    },
                    child: Text('Seçeneksiz Buton'),
                  ),
              
                  ElevatedButton(
                    onPressed: () async {
                      await _showMyDialog(
                        'Buton 2',
                        'Açıklama 1',
                        'Açıklama 2',
                        'Geri Dön',
                        'Devam Et',
                        true,
                      );
                    },
                    child: Text('İki seçenekli Buton'),
                  ),
              
                  ElevatedButton(
                    onPressed: () async {
                      await _showMyDialogWithTextField();
                    },
                    child: Text('Text Fieldli Buton'),
                  ),
              
                  ElevatedButton(
                    onPressed: () {
                      _showActionSheet(context);
                    },
                    child: Text('CupertinoActionSheet'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
