import 'package:flutter/material.dart';
import 'package:notification_center/timer_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    // Benim klasik bildirim fonksiyonum. Kontrol edip sayfa yönlendirmesi yapıyor
    void showMessage() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Şifreyi Giriniz'),
            content: TextField(controller: passwordController),

            actions: [
              TextButton(
                onPressed: () {
                  if (passwordController.text == '123') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TimerScreen(),
                      ),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text('Şifre: 123'),

            ElevatedButton(
              onPressed: () {
                showMessage();
              },
              child: Text('Şifreyi Çöz'),
            ),
          ],
        ),
      ),
    );
  }
}
