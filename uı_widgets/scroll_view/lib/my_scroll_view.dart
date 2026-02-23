import 'package:flutter/material.dart';

class MyScrollView extends StatefulWidget {
  const MyScrollView({super.key});

  @override
  State<MyScrollView> createState() => _MyScrollViewState();
}

class _MyScrollViewState extends State<MyScrollView> {
  final ScrollController _scrollController = ScrollController();
  bool _isShown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {

      // Gemini böyle bir yöntem önerdi, beğendim
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0 &&
          !_isShown) {
        _isShown = true;

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Sistem Uyarısı"),
            content: const Text("En alta ulaştın!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Geri Dön"),
              ),
            ],
          ),
        );
      }
    });
  }
  
  // Koray kendi projelerinde dispose kullanımını hep aksatıyorsun dikkat et
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: screenHeight * 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.red, width: 2),

                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('test'),
                    Text('test'),
                    Text('test'),
                    Text('test'),
                    Text('test'),
                    Text('test'),
                    Text('test'),
                    Text('test'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
