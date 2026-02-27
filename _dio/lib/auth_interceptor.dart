import 'package:dio/dio.dart';

// Her isteğe otomatik olarak bir "bearer token" ekleyen bir sınıf
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Tokenimizi tanımladık
    const String yourAuthToken = "insert your token here";

    // Header'e token ekledik
    options.headers['Authorization'] = 'Bearer $yourAuthToken';

    options.headers['User-Agent'] = 'dio/5.0.0';
    options.headers['Accept'] = '*/*';

    print('İstek gönderiliyor: ${options.path}');

    // İşlemin devam etmesi için handler.next demek lazımmış biraz garip
    return handler.next(options);
  }

  // Hata yazıcısı
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      print('Token süresi dolmuş ya da yetkisiz erişim.');
    }
    return handler.next(err);
  }
}
