import 'package:flutter/material.dart';
import 'package:grid_view/app_model.dart';

class AppDetailView extends StatelessWidget {
  AppModel appModel;

  AppDetailView({super.key, required this.appModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${appModel.appName}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appModel.appIcon,

                    SizedBox(height: 16),

                    Image(
                      image: NetworkImage(appModel.appCover),
                      fit: BoxFit.cover,
                      width: 160,
                    ),

                    SizedBox(height: 16),

                    Text('Ad: ${appModel.appName}'),
                    Text('Kategori: ${appModel.appCategory}'),
                    Text(
                      'Tarih: ${appModel.releaseDate.toString().split(" ")[0]}',
                    ),
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
