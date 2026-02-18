import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Ben eskiden SharedPreferences kullanıyordum ama artık cache ile olan yapıya geçilmiş
class Sp extends ChangeNotifier {
  // Yeni cache yöntemiyle veriler uygulama açılışında bir kere belleğe yüklenir ve hep oradan çağrılır
  SharedPreferencesWithCache? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions( // Burada ihtiyacımız olan keyleri alıyoruz
        allowList: {_firstName, _lastName, _visitCount, _beenAbroad},
      ),
    );
    // Değişikliği notifier ile her yere bildir
    notifyListeners();
  }

  static const String _firstName = 'firstName';
  static const String _lastName = 'lastName';
  static const String _visitCount = 'visitCount';
  static const String _beenAbroad = 'beenAbroad';

  // UI için okuma
  String get firstName => _prefs?.getString(_firstName) ?? '';
  String get lastName => _prefs?.getString(_lastName) ?? '';
  int get visitCount => _prefs?.getInt(_visitCount) ?? 0;
  bool get beenAbroad => _prefs?.getBool(_beenAbroad) ?? false;

  // Kişisel Bilgileri Kaydetme

  Future<void> setFirstName(String value) async {
    if (_prefs != null) {
      await _prefs!.setString(_firstName, value);
      notifyListeners();
    }
  }

  Future<void> setLastName(String value) async {
    if (_prefs != null) {
      await _prefs!.setString(_lastName, value);
      notifyListeners();
    }
  }

  Future<void> setVisitCount(int value) async {
    if (_prefs != null) {
      await _prefs!.setInt(_visitCount, value);
      notifyListeners();
    }
  }

  Future<void> setBeenAbroad(bool value) async {
    if (_prefs != null) {
      await _prefs!.setBool(_beenAbroad, value);
      notifyListeners();
    }
  }
}
