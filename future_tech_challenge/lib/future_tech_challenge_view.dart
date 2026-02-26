import 'package:flutter/material.dart';
import 'package:future_tech_challenge/app_list.dart';
import 'package:future_tech_challenge/controller_status_model.dart';

class FutureTechChallengeView extends StatefulWidget {
  const FutureTechChallengeView({super.key});

  @override
  State<FutureTechChallengeView> createState() =>
      _FutureTechChallengeViewState();
}


// Birkaç görevdir aynı tarz şeyleri yaptığım için çok uğraşmak istemedim. Konsepti kavradım zaten. İstenilenleri yaptım fazlasını yapmadım.
class _FutureTechChallengeViewState extends State<FutureTechChallengeView> {
  // İdareten böyle bir yapı kurdum dışarıdan erişim varmış gibi göstermek için
  final ourApp = ControllerStatusModel(
    name: 'FutureTech',
    status: false,
    myTime: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Future Tech Challenge',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flexible en dışta olmalı yoksa çöküyor
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      ourApp.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    ourApp.status ? 'Açık' : 'Kapalı',
                    style: TextStyle(
                      color: ourApp.status ? Colors.green : Colors.red,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(ourApp.myTime.toString().split(" ")[0]),
                  ),
                ),
              ],
            ),
          ),

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: futureTechDevices.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final app = futureTechDevices[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: app.status ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(child: Image.network(app.imageUrl)),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(app.name),
                        ),
                      ),

                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              app.status
                                  ? app.status = false
                                  : app.status = true;
                            });
                          },
                          child: Text(
                            app.status ? 'Kapat' : 'Aç',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                          ),
                        ),
                      ),
                    ],
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
