import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePage extends StatefulWidget {
  const LottiePage({super.key});

  @override
  State<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> with TickerProviderStateMixin {
  bool _isLoading = true;
  bool _isProcessing = false;
  bool _isCancelled = false;
  double _progress = 0;
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _simulateSharpening();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _startSharpening() async {
    setState(() {
      _isProcessing = true;
      _isCancelled = false;
    });

    if (_progress != 0) {
      for (var i = (_progress * 100).toInt(); i <= 100; i++) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (_isCancelled) break;
        setState(() {
          _progress = i / 100;
          _controller.value = _progress.clamp(0.0, 1.0);
        });
      }
    } else {
      for (var i = 0; i <= 100; i++) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (_isCancelled) break;
        setState(() {
          _progress = i / 100;
          _controller.value = _progress.clamp(0.0, 1.0);
        });
      }
    }

    setState(() {
      _isProcessing = false;
    });
  }

  void _simulateSharpening() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lottie', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Column(
              children: [
                // UYGULAMANIN İLK AÇILIŞI
                Lottie.network(
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/LottieLogo1.json', // Örnek URL
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Fotoğraf kesinleştiriliyor!'),
                ),
              ],
            )
          : Column(
              children: [
                // UYGULAMA AÇILIŞI GEÇTİKTEN SONRA
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Image.network(
                    'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
                    color: Colors.white.withOpacity(
                      _progress < 0.3 ? 0.3 : _progress,
                    ),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),

                Lottie.network(
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/LottieLogo1.json', // Örnek URL
                  controller: _controller,
                  // internetten inen bir dosya olduğu için süreyi böyle ayarladık
                  onLoaded: (composition) {
                    _controller.duration = composition.duration;
                  },
                  width: 200,
                  height: 200,
                ),

                Text(_progress.toString()),

                ElevatedButton(
                  onPressed: () {
                    _progress = 0;
                    _startSharpening();
                  },
                  child: Text('Keskinleştirmeyi başlat'),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isProcessing = false;
                      _isCancelled = true; // Döngüyü kırar
                      _controller.stop();
                    });
                  },
                  child: Text('Keskinleştirmeyi durdur'),
                ),

                ElevatedButton(
                  onPressed: () => _isProcessing ? null : _startSharpening(),
                  child: Text('Keskinleştirmeye devam et'),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isProcessing = false;
                      _isCancelled = true;
                      _progress = 0;
                      _controller.reset();
                    });
                  },
                  child: Text('Keskinleştirmeyi iptal et'),
                ),
              ],
            ),
    );
  }
}
