import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

// Bu kısmı Gemini'ye yaptırdım
// Bu fonksiyon dosyayı okur, tirelerden ayırır, harfe çevirir ve sonucu verir.
Future<String> readAndDecryptMessage(String path) async {
  try {
    // 1. Metin dosyasını ham metin ("8-5-12...") olarak oku
    String rawData = await rootBundle.loadString(path);

    // 2. Tirelerden ayır, her sayıyı harfe çevir ve birleştir
    String decrypted = rawData
        .split('-')
        .map((n) {
          int? code = int.tryParse(n.trim());
          // ASCII: 1+64=65 (A), 2+64=66 (B)...
          return code != null ? String.fromCharCode(code + 64) : "";
        })
        .join('');

    return decrypted; // "HELLOKORAY" gibi bir String döner
  } catch (e) {
    return "Hata: Dosya okunurken veya deşifre edilirken sorun çıktı!";
  }
}

class NotificationCenter {
  // Mesajları yayınlayacağımız kanal (telsiz hattı gibi düşün Koray)
  static final StreamController<String> _streamController =
      StreamController<String>.broadcast();

  // Mesajı gönder
  static void postDecryptedMessage(String message) {
    _streamController.sink.add(message);
  }

  // Mesajı dinleyen telsiz hattımız gibi düşün
  static Stream<String> get onMessageReceived => _streamController.stream;
}
