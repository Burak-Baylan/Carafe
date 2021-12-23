import 'package:cloud_firestore/cloud_firestore.dart';

class LikeModel {
  String authorId;
  Timestamp createdAt;

  LikeModel({
    required this.authorId,
    required this.createdAt,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      authorId: json['author_id'] as String,
      createdAt: json['created_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'author_id': authorId,
        'created_at': createdAt,
      };

  @override
  String toString() =>
      "[[[(((AuthorId: $authorId | CreatedAt: $createdAt)))]]]";
}
