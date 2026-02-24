import 'package:flutter/material.dart';
import 'package:grid_view/app_model.dart';

class AppDetailView extends StatelessWidget {
  AppModel appModel;

  AppDetailView({super.key, required this.appModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ayrıntı'), backgroundColor: Colors.red),
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
                    Text(appModel.appName),
                    Text(appModel.appCategory),
                    Text(appModel.releaseDate.toString().split(" ")[0]),
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
