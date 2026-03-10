import 'package:clean_architecture/features/daily_news/domain/entities/article.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
         // BU KISIM EKSİKTİ: Verileri Entity'ye paslıyoruz (Garip bir yöntem)
         id: id,
         author: author,
         title: title,
         description: description,
         url: url,
         urlToImage: urlToImage,
         publishedAt: publishedAt,
         content: content,
       );

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      // JSON anahtarlarının görseldekiyle (camelCase) aynı olduğundan emin ol
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      urlToImage: map['urlToImage'] ?? "",
      publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }
}
