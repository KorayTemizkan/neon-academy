import 'dart:convert';
import 'package:_api/album_model.dart';
import 'package:http/http.dart' as http;

/*
Biliyordum ama temelden tekrar yaptım güzel oldu.
İstekte 12 farklı tür demiş ama ben resmi dökümandaki gibi id, title ve userId'ye göre yaptım ama mantığı biliyorum
İlk hafta konularında çok özellikli nesneler üzerinden yapmıştım, aynı zamanda Tığcık projemde de. Vakit kaybetmemek için geçtim bu kısmı.
Hem Api hem de HTTP kısımlarına aynı dosyaları yükleyecem çünkü bu iki konu neredeyse iç içe.


API nedir? Application Programming Interface (Uygulama Programlama Arayüzü):

İki yazılımın birbiriyle iletişimine denir. Sen hava durumu görmek için sunucuya istek atarsın
Sunucu da sana cevabı yollar. 

REST nedir? Representational State Transfer (Temsili Durum Aktarımı):
Bir API'nin nasıl davranması gerektiğini belirleyen kurallar bütünüdür(Mimari tarzdır)
Eğer bir API RESTful ise o iletişimin uyması gereken protokoller var demektir.

Rest'in en büyük kuralı HTTP metotlarını kullanmaktır. GET, POST, PUT, DELETE
Stateless(durumsuz)dur. Sunucuya her istekte kim olduğunu hatırlatman gerekir
Resource-based(kaynak odaklı)dır. Her şey URL üzerindendir. (/criminals, /criminals/joker).
En çok JSON formatı kullanılır

(Tığcık üzerinden özet. Supabase API'sine REST kurallarına uygun bir get isteği atıp verileri indiriyoruz)
*/

// Future ve async yapısı kullanılır çünkü uygulama çalışırken bu fonksiyon çalışmaya devam eder
Future<AlbumModel> fetchAlbum() async {
  // http paketi kullanarak istek attık ve cevap döndü. Bunun gövdesi(body) ise String. Serialized data ya da JSON string diyebilirsin
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    // Header eklemezsen çoğu web sitesi bu isteği kabul etmez ve hata alırsın.
    headers: {
      'User-Agent': 'my-api-project',
      'Authorization': 'Bearer mytoken',
    },
  );

  if (response.statusCode == 200) {
    // Gövdemizi convert sınıfından jsonDecode ile Map ögesine dönüştürüyoruz.
    // { "name"}
    return AlbumModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to Load Album: ${response.statusCode}');
  }
}

// POST metodu, sıfırdan albüm oluşturduk
Future<AlbumModel> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type':
          'application/json; charset=UTF-8', // Sunucuya ne gönderdiğimizi söyledik
      'User-Agent': 'my-api-project',
      'Authorization': 'Bearer mytoken',
    },
    body: jsonEncode(<String, dynamic>{'title': title, 'userId': 1}),
    // neden id eklemiyoruz çünkü bu sunucu tarafında otomatik oluşur, biz hangi id'ye sahip kullanıcıyı ve içeriği gönderiyoruz yetiyor
  );

  // 201 created status oluyormuş
  if (response.statusCode == 201) {
    return AlbumModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to Create Album:  ${response.statusCode}');
  }
}

// PUT metodu, 1 numaralı id'ye sahip kişiyi güncelledik
Future<AlbumModel> editAlbum(String title) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type':
          'application/json; charset=UTF-8', // Sunucuya ne gönderdiğimizi söyledik
      'User-Agent': 'my-api-project',
      'Authorization': 'Bearer mytoken',
    },
    body: jsonEncode(<String, dynamic>{'title': title, 'userId': 1}),
  );

  // POST'tan farkı yeniden 200 kullanıyor olmamız
  if (response.statusCode == 200) {
    return AlbumModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to Edit Album:  ${response.statusCode}');
  }
}

// Delete metodu, varolan albümü sildik
Future<bool> deleteAlbum(String id) async {
  final response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type':
          'application/json; charset=UTF-8', // Sunucuya ne gönderdiğimizi söyledik
      'User-Agent': 'my-api-project',
      'Authorization': 'Bearer mytoken',
    },
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Delete Album:  ${response.statusCode}');
  }
}
