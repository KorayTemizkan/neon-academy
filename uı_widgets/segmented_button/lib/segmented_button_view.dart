import 'package:flutter/material.dart';
import 'package:segmented_button/my_segmented_button.dart';

class SegmentedButtonView extends StatefulWidget {
  const SegmentedButtonView({super.key});

  @override
  State<SegmentedButtonView> createState() => _SegmentedButtonViewState();
}

class _SegmentedButtonViewState extends State<SegmentedButtonView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: [SizedBox(height: 48), MySegmentedButton()])),
    );
  }
}
