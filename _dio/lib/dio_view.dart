import 'package:_dio/dio_service.dart';
import 'package:flutter/material.dart';

class DioView extends StatefulWidget {
  const DioView({super.key});

  @override
  State<DioView> createState() => _DioViewState();
}

class _DioViewState extends State<DioView> {
  dynamic debug = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupDio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MelodyMaker', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('JSONPlaceHolder\nile Dio Çalışması', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),

                    SizedBox(height: 16),
                    Text(textAlign: TextAlign.center, debug),

                    SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () async {
                        var result = await getPosts();

                        setState(() {
                          debug = result.toString();
                        });
                      },
                      child: Text('GET - İlk Eleman'),
                    ),

                    SizedBox(height: 16),
                    Divider(height: 2),
                    SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () async {
                        var result = await createPost();
                        setState(() {
                          debug = result.toString();
                        });
                      },
                      child: Text('POST - Yeni Eleman'),
                    ),

                    SizedBox(height: 16),
                    Divider(height: 2),
                    SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () async {
                        var result = await updatePost();
                        setState(() {
                          debug = result.toString();
                        });
                      },
                      child: Text('PUT - İlk Elemanı Güncelle'),
                    ),

                    SizedBox(height: 16),
                    Divider(height: 2),
                    SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () async {
                        var result = await deletePost();
                        setState(() {
                          debug = result.toString();
                        });
                      },
                      child: Text('DELETE - İlk Elemanı SİL'),
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
