import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color color;

  const CardView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.color,
  });

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        surfaceTintColor: widget.color,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image(image: NetworkImage(widget.imageUrl)),

              SizedBox(height: 16),

              Text('Title : ${widget.title}', style: TextStyle(fontSize: 24, color: widget.color)),
              Text(
                'Subtitle : ${widget.subtitle}',
                style: TextStyle(fontSize: 16, color: widget.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
