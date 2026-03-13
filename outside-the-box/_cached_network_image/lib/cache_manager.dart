import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyCustomCacheManager {
  static const _imageCacheKey = 'image_cache_key';
  
  // Private constructor ile dışarıdan "new" ile oluşturmayı engelledik
  MyCustomCacheManager._internal();
  
  // Singleton instance ile sınıfın tek bir örneğini sakladık
  static CacheManager instance = CacheManager(
    Config(
      _imageCacheKey,
      stalePeriod: const Duration(
        days: 7,
      ), // Standart 30 gün yerine 7 gün olarak ayarladık
      maxNrOfCacheObjects: 100, // En fazla 100 görsel tut
      repo: JsonCacheInfoRepository(), // Dosyaların meta takibini sağlarız (ne zaman indi, son kullanma tarihi vb.)
      fileService: HttpFileService(),  // dosyaların internetten standart http protokolüyle indirileceğini belirttik
    ),
  );
}
