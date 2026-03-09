import 'package:dio/dio.dart';

// Buradaki sınıf bir şablondur. T harfi generic yapıyı temsil eder. Yani buraya ister User, ister başka bir nesne koyabilirsin
abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}

/*

Burası data ve domain katmanları arasındaki iletişimi standart hale getirmek için kullanılan bir sarma(wrapper) sınıftır.

Uygulamanın herhangi bir yerinde veri çekerken (Api ya da Database) işlemin başarılı olup olmadığını öğrenmemizi sağlar

*/