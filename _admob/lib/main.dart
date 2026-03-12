import 'dart:async';

import 'package:_admob/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Reklam kurulumu
  unawaited(MobileAds.instance.initialize());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

/* 

Kaynak: https://docs.flutter.dev/resources/ads-overview


! Android app ID/ad unit ID

AdMob app ID
	

ca-app-pub-3940256099942544~3347511713

Banner
	

ca-app-pub-3940256099942544/6300978111

Interstitial
	

ca-app-pub-3940256099942544/1033173712

Rewarded
	

ca-app-pub-3940256099942544/5224354917


!iOS app ID/ad unit ID


AdMob app ID
	

ca-app-pub-3940256099942544~1458002511

Banner
	

ca-app-pub-3940256099942544/2934735716

Interstitial
	

ca-app-pub-3940256099942544/4411468910

Rewarded
	

ca-app-pub-3940256099942544/1712485313
*/
