import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String imageUrl;
  final String ownerId;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.imageUrl,
    required this.ownerId,
    required this.createdAt,
  });

  // Firestore verisini Dart nesnesine dönüştürmek
  factory PostModel.fromFirestore(Map<String, dynamic> data, String id) {
    return PostModel(
      id: id,
      imageUrl: data['imageUrl'] ?? '',
      ownerId: data['ownerId'] ?? '',
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  // Dart nesnesini Firestore'a göndermek için Map'e dönüştürmek
  Map<String, dynamic> toFirestore() {
    return {'imageUrl': imageUrl, 'ownerId': ownerId, 'createdAt': createdAt};
  }
}
