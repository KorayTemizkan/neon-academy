/*
! cached_network_image ile flutter_cache_manager arasındaki farkı

? cached_network_image
Hazır arayüz bileşendiir. Bu paket bir widgettir, internetten bir görseli çekip
bunu ekranda gösterirken aynı zamanda otomatik olarak önbelleğe almaktadır
Sadece görseller içindir

Paket uygulama boyutunu şişirmemek için bazı yöntemler uygular,
maksimum dosya sınırı
saklama süresi


? flutter_cache_manager
Bir servis motorudur. Her türlü dosyayı indirmek ve yönetmek için kullanılır
Özelleştirilebilirdir.


? Uygulamadan çık gir, internettsiz yüklenmiş olucak

*/

import 'package:_cached_network_image/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImagePage extends StatefulWidget {
  const CachedNetworkImagePage({super.key});

  @override
  State<CachedNetworkImagePage> createState() => _CachedNetworkImagePageState();
}

class _CachedNetworkImagePageState extends State<CachedNetworkImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cached Network Image',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          Center(
            child: CachedNetworkImage(
              cacheManager: MyCustomCacheManager.instance,
              imageUrl:
                  "https://www.bogatepemandira.com/images/urunler/test-urun--145-16082397730-1000.png",
              imageBuilder: (context, imageProvider) => Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          
          ElevatedButton(
            onPressed: () async {
              await MyCustomCacheManager.instance.emptyCache();
            },
            child: Text('Önbelleği temizle'),
          ),
        ],
      ),
    );
  }
}
