class CommentModel {
  final String id;
  final String comment;
  final String ownerId;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.comment,
    required this.ownerId,
    required this.createdAt,
  });

  factory CommentModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CommentModel(
      id: id,
      comment: data['comment'] ?? '',
      ownerId: data['ownerId'] ?? '',
      createdAt: data['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'comment': comment, 'ownerId': ownerId, 'createdAt': createdAt};
  }
}
