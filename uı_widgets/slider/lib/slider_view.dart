import 'package:flutter/material.dart';

class SliderView extends StatefulWidget {
  const SliderView({super.key});

  @override
  State<SliderView> createState() => _SliderViewState();
}

// Yararlandığım kaynak
// https://api.flutter.dev/flutter/material/Slider-class.html

class _SliderViewState extends State<SliderView> {
  double _currentSliderValue = 20;
  double _currentSliderValueDiscrete = 20;
  String debug = 'Henüz Savaşmadın!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 48),
        
            /*
            The academy members were tasked with creating this slider, and they worked tirelessly to make sure it was perfect.
            They gave the minimum value of the slider an image of a green dragon, and the maximum value an image of a red dragon.
            The track color of the slider went from green to red in a gradient, representing the dragon's power. 
            The thumb color of the slider was blue, representing the princesses' hope.
            */
            Text('Seri'),
            Row(
              children: [
                Expanded(
                  child: Image(
                    image: NetworkImage(
                      'https://i.pinimg.com/736x/7a/59/94/7a59947b19c668e8b63a0ddd3928d26a.jpg',
                    ),
                  ),
                ),
                Slider(
                  // Yeşilden kırmızıya geçişte verilen değeri ayarlama için kullandık
                  activeColor: Color.lerp(
                    Colors.green,
                    Colors.red,
                    _currentSliderValue / 100,
                  ),
                  thumbColor: Colors.blue,
                  min: 0,
                  label: 'SLİDER',
                  max: 100,
                  value: _currentSliderValue,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                Expanded(
                  child: Image(
                    image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkBXR-q_zlIxg_6O3G4pgJ9pHvySyhS7Y1jA&s',
                    ),
                  ),
                ),
              ],
            ),
        
            SizedBox(height: 24),
            Divider(height: 2, color: Colors.grey),
            SizedBox(height: 24),
        
            /*
            The academy members set the slider's values to increase by one, not by commas, making it easier to navigate the forest and cross the bridge.
            They tested the slider and it worked perfectly. With the magical slider in hand, the academy members set out to rescue the princesses.
            */
            Text('Ayrık'),
            Slider(
              // Yeşilden kırmızıya geçişte verilen değeri ayarlama için kullandık
              activeColor: Color.lerp(
                Colors.green,
                Colors.red,
                _currentSliderValueDiscrete / 100,
              ),
              thumbColor: Colors.blue,
              min: 0,
              label: 'AYRIK SLİDER',
              divisions: 100,
              max: 100,
              value: _currentSliderValueDiscrete,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValueDiscrete = value;
                });
              },
            ),
        
            SizedBox(height: 24),
            Divider(height: 2, color: Colors.grey),
            SizedBox(height: 24),
        
            /*
            They navigated through the dangerous forest and crossed the treacherous bridge.
            When they reached the dragon, they pulled out the magical slider and set the value to 50.
            The red dragon appeared, and the academy members fought bravely, using all their skills to defeat the dragon.
            */
            Text('50 yap savaş!'),
            Slider(
              onChangeEnd: (double value) {
                if (value == 50) {
                  setState(() {
                  debug = 'Savaştın ve Kazandın!';
                    
                  });
                }
              },
              // Yeşilden kırmızıya geçişte verilen değeri ayarlama için kullandık
              activeColor: Color.lerp(
                Colors.green,
                Colors.red,
                _currentSliderValueDiscrete / 100,
              ),
              thumbColor: Colors.blue,
              min: 0,
              label: '$_currentSliderValueDiscrete',
              divisions: 20,
              max: 100,
              value: _currentSliderValueDiscrete,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValueDiscrete = value;
                });
              },
            ),
        
            SizedBox(height: 24),
            Divider(height: 2, color: Colors.grey),
            SizedBox(height: 24),

            Text('$debug',style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
