import 'package:_api/album_model.dart';
import 'package:_api/api_services.dart';
import 'package:flutter/material.dart';

// https://docs.flutter.dev/cookbook/networking/fetch-data
class ApiView extends StatefulWidget {
  const ApiView({super.key});

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  late Future<AlbumModel> _futureAlbum;
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureAlbum = fetchAlbum();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API ve HTTP', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // async bir yapımız olduğu için FutureBuilder kullanarak uı ile iletişim kurdurduk
            Text('GET METODU: albums/1 cevabı'),
            FutureBuilder<AlbumModel>(
              future: _futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.title);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),

            SizedBox(height: 24),
            Divider(height: 2),
            SizedBox(height: 24),

            Text(
              'DİKKAT! Yeni öge albums/1 konumuna eklenmiyor, işlemi görmek için cevabı mevcut album\'a atıyorum!',
            ),
            SizedBox(height: 8),
            Text('POST METODU: /albums konumuna yeni gönderim'),

            SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Metin Giriniz',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureAlbum = createAlbum(_controller.text);
                });
              },
              child: const Text('Yeni Öge Ekle'),
            ),

            SizedBox(height: 24),
            Divider(height: 2),
            SizedBox(height: 24),

            Text(
              'DİKKAT! En alttaki sil metodu kullanıldıktan sonra put metodu kullanılamaz çünkü silinmiş öge üzerinde işlem yapılamaz!',
            ),
            SizedBox(height: 8),
            Text('PUT METODU: /albums/1 güncellemesi'),
            SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Metin Giriniz',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureAlbum = editAlbum(_controller.text);
                });
              },
              child: const Text('Güncelle'),
            ),

            SizedBox(height: 24),
            Divider(height: 2),
            SizedBox(height: 24),

            Text('DELETE METODU: /albums/1 sil'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureAlbum = editAlbum('1');
                });
              },
              child: const Text('1 Numarayı Sil'),
            ),
          ],
        ),
      ),
    );
  }
}
