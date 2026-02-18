/*
Kendi projemde kullanmak için geri sayım aracına ihtiyacım vardı. BU görevde de işime yarayacaktı. O yüzden bu sitedeki kişiden yardım aldım
https://medium.com/@dtejaswini.06/building-a-countdown-timer-in-flutter-with-animation-a-step-by-step-guide-9ffa91e3d26e
Gemini'ye yaptırmaktansa böyle şeyleri internetten bulmayı daha çok seviyorum. Biraz zahmet olmayınca yeterince akılda kalmıyor.
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notification_center/decrypter.dart';
import 'package:notification_center/waiting_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // Bunu iki tarih arasını hesaplarken de kullanmıştım.
  // Geri sayımın hangi süreden başlayacağını ayarladık.
  // static const ile bu değer bellekte bir kere oluşturulur ve asla değiştirilemez
  static const Duration countDownDuration = Duration(minutes: 0, seconds: 2);

  // Değişim bildirici tanımladık. ChangeNotifier kullanıyorduk ya onun gibi
  // Ekranın tamamını setState ile yeniden çizmek yerine sadece bu süreye bağlı olan widgeti tetikler
  final ValueNotifier<Duration> durationNotifier = ValueNotifier<Duration>(
    countDownDuration,
  );

  // Belirli aralıklarla (örneğin her 1 saniyede bir) bir fonksiyonu çalıştırmak için kullanılır
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer(); // Kullanıcı sayfaya girdiği anda sayaç başlar
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Kaynakların serbest bırakıldığı nokta
    timer?.cancel();
    durationNotifier.dispose();
    super.dispose();
  }

  // Her bir saniyede bir zamanlayıcıyı bir azaltır ve addTime fonksiyonunu tetikler
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  // Mevcut süreyi bir azalt ve gerekli kontrolleri yap. Eğer 0'dan düşük değilse yeni değeri ata
  void addTime() async {
    final seconds = durationNotifier.value.inSeconds - 1;

    if (seconds < 0) {
      timer?.cancel();
      String message = await readAndDecryptMessage('assets/message.txt');

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const WaitingScreen()));

      // Zamanlama hatası oluyordu Flutter'da o yüzden 1 saniye gecikme ekledim sorun çözüldü. Yayın yapılabiliyor
      Future.delayed(const Duration(seconds: 1), () {
        NotificationCenter.postDecryptedMessage(message);
      });
      // Bu şekilde daha önce hiç kullanmadım provider kullanmıştım ama bu da hoşmuş
    } else {
      durationNotifier.value = Duration(seconds: seconds);
    }
  }

  Widget buildTime(Duration duration) {
    // Örneğin saniye 9'a düştüğünde ekranda 09 olmasını sağlar, padLeft ile metin 2 karakterden azsa sola 1 sıfır ekler
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    // Two Digits iki birimlik gösterim yapmamızı sağlar
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(
      duration.inMinutes.remainder(60),
    ); // 65 saniye ise bunu 60'a bölüp kalanı alır
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeColumn(hours, "Hrs"),
        buildTimeColumn(minutes, "Mins"),
        buildTimeColumn(seconds, "Secs", isLast: true),
      ],
    );
  }

  // tüm sütun burada ayarlanır
  Widget buildTimeColumn(String time, String label, {bool isLast = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            buildDigit(time[0]),
            buildDigit(
              time[1],
            ), // animasyon geçişi için gereksiz yük oluşturmamak amaçlanmış, sadece sağdaki hareket ediyor.
            if (!isLast)
              buildTimeSeparator(), // en sağa gereksiz yere : koydurmaz
          ],
        ),
        buildLabel(label),
      ],
    );
  }

  Widget buildDigit(String digit) {
    // Bu widget çocuk öge değiştiği zaman yumuşak geçiş yapmamızı sağlar
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: Text(
        digit,
        key: ValueKey<String>(digit),
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Aradaki : işaretini düzenler
  Widget buildTimeSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: const Text(
        ":",
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }

  // Hrs, mins, secs metinlerini düzenler
  Widget buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text('Geri Sayım'),

            // Sadece değişen alanı güncelle, tüm sayfayı yeniden çizme. Güzel bir state management Widgeti
            // Mesela her seferinde arka planı tekrar sarı çizmiyor gibi düşün
            ValueListenableBuilder<Duration>(
              valueListenable:
                  durationNotifier, // Burada değişim olduğu için burayı dinliyor
              builder: (context, duration, child) {
                // Nereyi yeniden çizecek orayı ayarlıyoruz
                return buildTime(duration);
              },
            ),
          ],
        ),
      ),
    );
  }
}
