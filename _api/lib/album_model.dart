class AlbumModel {
  final int userId;
  final int id;
  final String title;

  const AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  // Buraya map ögesi gelir ve bunu teker teker parçalara ayırır ve AlbumModel "nesnesine" çevirir.
  // Bu arada ben böyle yazmıyorum daha güvenli bir yöntem kullanıyorum ama şu anlık resmi dökümanı kullanmam yeterli
  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => AlbumModel(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to Load Album'),
    };
  }
}
