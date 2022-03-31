import 'package:cloud_firestore/cloud_firestore.dart';

class VerificationRequestModel {
  String authorId;
  Timestamp createdAt;

  VerificationRequestModel({
    required this.authorId,
    required this.createdAt,
  });

  factory VerificationRequestModel.fromJson(Map<String, dynamic> json) {
    return VerificationRequestModel(
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
