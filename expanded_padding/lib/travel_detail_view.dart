import 'package:expanded_padding/travel_model.dart';
import 'package:flutter/material.dart';

class TravelDetailView extends StatefulWidget {
  final TravelModel travelModel;

  const TravelDetailView({super.key, required this.travelModel});

  @override
  State<TravelDetailView> createState() => _TravelDetailViewState();
}

class _TravelDetailViewState extends State<TravelDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ayrıntılar')),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 24),
             Card(
                  child: Column(
                    children: [
                      // Bu ClipRRect ile köşe yumuşatma yapılıyormuş
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: 120,
                          child: Image(
                            image: NetworkImage(widget.travelModel.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Text(widget.travelModel.name),
                      Text(widget.travelModel.country),
                      Text(widget.travelModel.continent),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
