import 'package:flutter/material.dart';

class ScreenAnimationsView extends StatefulWidget {
  const ScreenAnimationsView({super.key});

  @override
  State<ScreenAnimationsView> createState() => _ScreenAnimationsViewState();
}

class _ScreenAnimationsViewState extends State<ScreenAnimationsView> {
  double _opacity = 1; // Saydamlık
  double _turns = 0; // Döndürme
  double _yOffset = 0; // Hareket
  double _scale = 1; // Ölçek

  // Görünmez yapmak
  void _castInvisibility() {
    setState(() {
      if (_opacity == 0) {
        _opacity = 1;
      } else {
        _opacity = 0;
      }
    });
  }

  // 45 derece döndürmek
  void _castRotation() {
    setState(() {
      _turns += 45 / 360;
    });
  }

  // y ekseninde aşağı yukarı hareket
  void _castMovement() {
    setState(() {
      if (_yOffset == 0) {
        _yOffset = -50;
      } else {
        _yOffset = 0;
      }
    });
  }

  // Boyutu % 50 arttırıp azaltmak
  void _castSize() {
    setState(() {
      if (_scale == 1) {
        _scale = 1.5;
      } else {
        _scale = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Animations', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 96),

                /*
                Flutter'da her bir animated widgeti sadece tek bir görevi yerine getirir
                Burada iç içe yaparak aynı anda farklı seçenekleri yapmayı sağladık

                Bu sıralama da aslında önemliymiş, başka sıralamayla yaparsan bozulabiliyormuş dikkat
                Padding -> Scale -> Rotation -> Opacity -> Widget
                */
                AnimatedPadding(
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.only(top: _yOffset + 50),
                  child: AnimatedScale(
                    scale: _scale,
                    duration: Duration(milliseconds: 500),
                    child: AnimatedRotation(
                      turns: _turns,
                      duration: Duration(milliseconds: 500),
                      child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(milliseconds: 500),
                        child: Icon(
                          Icons.square,
                          size: 100,
                          color: Colors.blue,
                        ), // Viking Kalkanı
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 48),
                
                // WRAP(sarma offf), Row ya da column gibi çalışır ama sığmadığında alta taşar.
                // Bunu neden daha önce görmedim

                Wrap( 
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  children: [
                    ElevatedButton(
                      onPressed: _castInvisibility,
                      child: Text("Görünmezlik"),
                    ),
                    ElevatedButton(
                      onPressed: _castRotation,
                      child: Text("Döndürme"),
                    ),
                    ElevatedButton(
                      onPressed: _castMovement,
                      child: Text("Hareket"),
                    ),
                    ElevatedButton(onPressed: _castSize, child: Text("Boyut")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
