import 'package:expanded_padding/travel_detail_view.dart';
import 'package:expanded_padding/travel_list.dart';
import 'package:flutter/material.dart';

class ExpandedFlexibleView extends StatefulWidget {
  const ExpandedFlexibleView({super.key});

  @override
  State<ExpandedFlexibleView> createState() => _ExpandedFlexibleViewState();
}

class _ExpandedFlexibleViewState extends State<ExpandedFlexibleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanded&Flexible', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // sütun sayısı sabit kaç olacak
              mainAxisExtent: 240, // her bir sütunun yüksekliğini ayarlıyoruz
            ),
            itemCount: travelList.length,
            itemBuilder: (context, index) {
              final travelDestination = travelList[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            TravelDetailView(travelModel: travelDestination),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        // Bu ClipRRect ile köşe yumuşatma yapılıyormuş
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            height: 120,
                            child: Image(
                              image: NetworkImage(travelDestination.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /*
                        Text(
                          'Merhaba, burada padding kullanarak kenarlardan nefes alma payı bıraktık, expanded kullanarak ise test ettik. Merhaba, burada padding kullanarak kenarlardan nefes alma payı bıraktık, expanded kullanarak ise test ettik',
                        ), */
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Merhaba, burada padding kullanarak kenarlardan nefes alma payı bıraktık, expanded kullanarak ise taşmamasını sağladık. Merhaba, burada padding kullanarak kenarlardan nefes alma payı bıraktık, expanded kullanarak ise taşmamasını sağladık',
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
