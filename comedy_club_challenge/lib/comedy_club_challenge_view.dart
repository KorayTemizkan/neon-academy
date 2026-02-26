import 'package:comedy_club_challenge/comedy_club_model.dart';
import 'package:comedy_club_challenge/detail_view.dart';
import 'package:comedy_club_challenge/show_list.dart';
import 'package:flutter/material.dart';

class ComedyClubChallengeView extends StatefulWidget {
  const ComedyClubChallengeView({super.key});

  @override
  State<ComedyClubChallengeView> createState() =>
      _ComedyClubChallengeViewState();
}

// Bir önceki görev gibi burada da güzel bir tasarım isteniyor. Öncekine nazaran burada daha çok uğraşıcam.
// Ama çok bakmıyorum vakit kaybı olmasın zaten kendi uygulamamda yeterince tecrübe ettim
class _ComedyClubChallengeViewState extends State<ComedyClubChallengeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final myComedyClub = ComedyClubModel(
      name: 'MyComedy Club',
      city: 'İstanbul',
      imageUrl:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/06/bd/16/8b/the-improv-comedy-club.jpg?w=900&h=500&s=1',
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Comedy Club Challenge',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(myComedyClub.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withAlpha(200),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        myComedyClub.name,
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text(
                  'Etkinlikler',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  'Tümünü Gör',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comedyShows.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 240,
            ),
            itemBuilder: (context, index) {
              final show = comedyShows[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailView(model: show),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.pinkAccent, width: 2),
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            height: 120,
                            width: size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                show.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              show.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            textAlign: TextAlign.center,
                            show.category,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
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
