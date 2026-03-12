import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// ! Kaynak: https://docs.flutter.dev/resources/ads-overview
 
class HomePage extends StatefulWidget {
  // Banner Ad'in boyutu
  final AdSize adSize;

  // Bu idler Google'nin test idleridir.
  final String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  final String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  final String rewardedAdInitId = 'ca-app-pub-3940256099942544/5224354917';

  const HomePage({super.key, this.adSize = AdSize.banner});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool first = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAd();
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  // Reklamlar çok bellek tüketirler. Sayfa çıkışında kapatmak iyi bir tercih
  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  // ! REWARDED AD

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: widget.rewardedAdInitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _rewardedAd = ad;
          });

          _setRewardedCallbacks(ad);
        },
        onAdFailedToLoad: (error) {
          debugPrint('BannerAd failed to load $error');
        },
      ),
    );
  }

  // Kapatılınca tekrar yüklüyoruz ki sonraki buton basımına hazır olsun
  void _setRewardedCallbacks(RewardedAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadRewardedAd(); // Kapatılınca tekrar getir
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _loadRewardedAd();
      },
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('Kullanıcı ödülü kaptı: ${reward.amount} ${reward.type}');
        },
      );

      _rewardedAd = null; // Gösterilen reklamı temizle
      _loadRewardedAd(); // Yeni reklam yükle
    } else {
      print('Reklam henüz hazır değil!');
    }
  }

  // ! INTERSTITIAL AD

  void _loadInterstitialAd() {
    final interstitialAd = InterstitialAd.load(
      adUnitId: widget.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _interstitialAd = ad;
          });

          if (first) {
            _interstitialAd!.show();
            first = false;
          }
          _setInterstitialCallbacks(ad);
        },
        onAdFailedToLoad: (error) {
          debugPrint('BannerAd failed to load $error');
        },
      ),
    );
  }

  void _setInterstitialCallbacks(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadInterstitialAd(); // Kapatılınca tekrar getir
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _loadInterstitialAd();
      },
    );
  }

  // ! BANNER AD

  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.bannerAdUnitId,
      request: const AdRequest(),

      // Bu dinleyici reklam gibi kolay hata verebilecek ögeleri yönetmede iyi bir tercihtir
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          // Eğer reklam yüklenene kadar kullanıcı sayfadan çıkarsa yükleme yapma
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },

        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load $error');
          ad.dispose();
        },
      ),
    );

    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admob', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _interstitialAd == null
                ? _loadInterstitialAd()
                : _interstitialAd!.show(),
            child: Text('Geçiş Reklamı'),
          ),

          ElevatedButton(
            onPressed: () => _rewardedAd == null
                ? _loadRewardedAd()
                : _showRewardedAd(), // Bu fonksiyonun içinde .show() ve ödül mantığı var
            child: const Text('Video İzle Ödül Kazan'),
          ),
          Spacer(),
          SizedBox(
            width: widget.adSize.width.toDouble(),
            height: widget.adSize.height.toDouble(),
            child: _bannerAd == null
                ? const SizedBox()
                // ! Reklamlar widget değildir, yerel görünümlerdir. AdWidget bunu alıp widget yapar.
                : AdWidget(ad: _bannerAd!),
          ),
        ],
      ),
    );
  }
}
