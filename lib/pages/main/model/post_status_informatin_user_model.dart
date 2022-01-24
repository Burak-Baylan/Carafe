import 'package:cloud_firestore/cloud_firestore.dart';

class PostStatusInformationUserModel {
  String authorId;
  Timestamp viewedAt;

  PostStatusInformationUserModel({
    required this.authorId,
    required this.viewedAt,
  });

  factory PostStatusInformationUserModel.fromJson(Map<String, dynamic> json) {
    return PostStatusInformationUserModel(
      authorId: json['author_id'] as String,
      viewedAt: json['created_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'author_id': authorId,
        'created_at': viewedAt,
      };

  @override
  String toString() => "[[[(((AuthorId: $authorId | CreatedAt: $viewedAt)))]]]";
}
