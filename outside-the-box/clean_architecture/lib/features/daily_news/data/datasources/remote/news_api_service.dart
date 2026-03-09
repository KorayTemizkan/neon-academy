import 'package:dio/dio.dart';
import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/features/daily_news/data/models/article.dart';

class NewsApiService {
  final Dio _dio;

  NewsApiService(this._dio);

  Future<Response<List<ArticleModel>>> getNewsArticles({
    String? apiKey,
    String? country,
    String? category,
  }) async {
    try {
      // Retrofit'in @GET ve @Query ile yaptığı işi burada manuel yapıyoruz
      final response = await _dio.get(
        '$newsAPIBaseURL/top-headlines',
        queryParameters: {
          'apiKey': apiKey,
          'country': country,
          'category': category,
        },
      );

      if (response.statusCode == 200) {
        // API'den gelen 'articles' listesini ham veri olarak alıyoruz
        final List<dynamic> data = response.data['articles'];

        // Ham JSON verisini ArticleModel listesine dönüştürüyoruz
        final articles = data
            .map((json) => ArticleModel.fromJson(json))
            .toList();

        // Veriyi Repository katmanının beklediği formatta döndürüyoruz
        return Response(
          requestOptions: response.requestOptions,
          data: articles,
          statusCode: response.statusCode,
        );
      } else {
        throw Exception("API Hatası: ${response.statusCode}");
      }
    } on DioException catch (e) {
      // İnternet hatası veya zaman aşımı gibi durumları yakalar
      rethrow;
    }
  }
}
/*

@RestApi ile Retrofit'e bu sınıfın bir api servisi olduğunu ve tüm isteklerin newsAPIBaseUrl sabiti üzerinden gideceğini söyler

Get metodu ile hangi endpointe istek atılacağı belirtilir

Query parametreleri ile query sonuna eklenecek filtreler eklenir 

En son olarak da http isteği atılmış olunur

flutter pub run build_runner build --delete-conflicting-outputs
*/