abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}

/*

Tüm use caselerin uyması gereken standart bir taban sınıf şablonudur

*/
