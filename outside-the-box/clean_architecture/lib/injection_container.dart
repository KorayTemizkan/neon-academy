import 'package:clean_architecture/features/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> initializeDependencies() async {
  // Dio (Dış Paket)
  sl.registerSingleton<Dio>(Dio());

  // API Service
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  // Repository
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  // UseCase
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  // Bloc
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
}

/*

Projedeki tüm katmanları birbirine bağlayan kısımdayız.
Bu sayede bir sınıfa ihtiyaç duyduğunda onu manuel olarak oluşturmakla uğraşmayız,

registerSingleton uygulama boyunca nesnenin tek bir kopyasını oluşturur. ApiService ya da Repository gibi sürekli aynı kalması gereken yapılar içindir.
registerLazySingleton uygulama boyunca nesnenin tek bir kopyasını oluşturur ama ögeye ihtiyaç olduğunda.
registerFactory her çağrıldığında yeni bir kopya oluşturur. Cubit gibi her ekran açıldığında sıfırlanması gereken yapılar içindir.

! EXTERNAL           DATA                    DOMAİN            PRESENTATİON
Dio -> NewsApiService -> ArticleRepositoryImpl -> GetArticleUseCase -> RemoteArticlesBloc

?Bu sayfayı bir kez main.dart içinde çağırdığında:
*Bloc, UseCase'e bağımlı olduğunu bilir.
*UseCase, Repository'ye bağımlı olduğunu bilir.
*Repository, ApiService'e bağımlı olduğunu bilir.
*/