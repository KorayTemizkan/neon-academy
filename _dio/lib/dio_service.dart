// https://pub-dev.translate.goog/packages/dio?_x_tr_sl=en&_x_tr_tl=tr&_x_tr_hl=tr&_x_tr_pto=tc
// https://cenkerkumlucali0.medium.com/flutter-dio-paketi-i%CC%87htiya%C3%A7lar%C4%B1n%C4%B1za-g%C3%B6re-ayarlanabilen-http-i%CC%87stemciniz-c15a8fa9d837
// Dio paketinin get, post, put ve delete işlemlerini burada görücez

import 'package:_dio/auth_interceptor.dart';
import 'package:dio/dio.dart';

// Önce dio nesnesi oluşturuyoruz ve bu nesne üzerinden çalışıyoruz.
final dio = Dio(
  // Zaman aşımları ekledik, bir isteğin sonsuza kadar beklemesini istemeyiz.
  BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 5), // max sunucuya bağlanma süresi
    receiveTimeout: const Duration(seconds: 3), // max veriyi alma süresi
  ),
);

void setupDio() {
  dio.interceptors.add(AuthInterceptor());

  // Dio'nun hazır loglayıcısını da ekleyebilirmişiz.
  dio.interceptors.add(LogInterceptor(responseBody: true));
}

// HTTP'ye göre hatayı daha iyi analiz etmemizi sağlıyor.
String handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return "Sunucuya bağlanılamadı, internetinizi kontrol edin.";
    case DioExceptionType.receiveTimeout:
      return "Sunucudan yanıt gelmesi çok uzun sürdü.";
    case DioExceptionType.badResponse:
      return "Sunucu hatası: ${error.response?.statusCode}";
    case DioExceptionType.cancel:
      return "İstek iptal edildi.";
    default:
      return "Beklenmedik bir hata oluştu.";
  }
}

// GET metodu
Future<dynamic> getPosts() async {
  try {
    Response res = await dio.get('/posts/1');

    if (res.statusCode == 200) {
      print(res.data.toString());
      return res.data;
    }
  } on DioException catch (e) {
    /* en klasik yöntem buydu
    print('Hata kodu: ${e.response?.statusCode}');
    print('Hata mesajı: ${e.response?.statusMessage}');
    */ // Artık ise böyle
    final errorMessage = handleDioError(e);
    print(errorMessage);
    return errorMessage;
  }
}

// POST metodu
Future<dynamic> createPost() async {
  try {
    Response res = await dio.post(
      '/posts',
      data: {
        'title': 'Flutter Post Test',
        'body': 'Dio Paketi Ile Post Istegim',
        'userId': 1,
      },
    );

    if (res.statusCode == 201) {
      print(res.data.toString());
      return res.data;
    }
  } on DioException catch (e) {
    final errorMessage = handleDioError(e);
    print(errorMessage);
    return errorMessage;
  }
}

// PUT metodu
Future<dynamic> updatePost() async {
  try {
    Response res = await dio.put(
      '/posts/1',
      data: {
        'id': 1,
        'title': 'Güncellenmiş Başlık',
        'body': 'Dio Paketi Ile Guncellenmis Post Istegim',
        'userId': 1,
      },
    );
    if (res.statusCode == 200) {
      print(res.data.toString());
      return res.data;
    }
  } on DioException catch (e) {
    final errorMessage = handleDioError(e);
    print(errorMessage);
    return errorMessage;
  }
}

// DELETE metodu
Future<dynamic> deletePost() async {
  try {
    Response res = await dio.delete('/posts/1');
    if (res.statusCode == 200) {
      print(res.data.toString());
      print('Silme işlemi başarılı');
      return 'Silme işlemi başarılı';
    }
  } on DioException catch (e) {
    final errorMessage = handleDioError(e);
    print(errorMessage);
    return errorMessage;
  }
}
