import 'dart:io';
import 'package:dio/dio.dart';
import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/core/resources/data_state.dart';
import 'package:clean_architecture/features/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:clean_architecture/features/daily_news/data/models/article.dart';
import 'package:clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      // NewsApiService artık doğrudan Dio Response döndürüyor
      final response = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      // response.statusCode üzerinden kontrol yapıyoruz
      if (response.statusCode == HttpStatus.ok) {
        // Dio'da veri doğrudan .data içindedir
        return DataSuccess(response.data!);
      } else {
        return DataFailed(
          DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType
                .badResponse, // Güncel Dio sürümünde bu ismi kullan
            requestOptions: response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      // İnternet hatası vb. durumlar için catch eklemek sağlıklıdır
      return DataFailed(e);
    }
  }
}

/*

Bu sınıf, domain katmanındaki soyut ArticleRepository arayüzünü uygular.
Yani veri nasıl çekilecek sorusunun gerçek cevabı buradadır.

Mesela NewsApiService yerine başka bir api kullanmak istersek bu sayfada sadece final response kısmını değiştireceğiz.
Diğer her şey aynı kalacak. Bağımsız olmayı sağladık

ArticleModel Listesi döndürüyoruz çünkü data katmanında ham veriyle çalışırız

Sonucu DataSuccess ile sarmalayıp uı'ye öyle veriyoruz. 
*/
