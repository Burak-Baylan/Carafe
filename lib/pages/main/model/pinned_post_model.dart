import 'package:cloud_firestore/cloud_firestore.dart';

class PinnedPostModel {
  String authorId;
  String postId;
  Timestamp createdAt;

  PinnedPostModel({
    required this.authorId,
    required this.postId,
    required this.createdAt,
  });

  factory PinnedPostModel.fromJson(Map<String, dynamic> json) {
    return PinnedPostModel(
      authorId: json['author_id'] as String,
      postId: json['postId'] as String,
      createdAt: json['created_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'author_id': authorId,
        'postId': postId,
        'created_at': createdAt,
      };

  @override
  String toString() =>
      "[[[(((AuthorId: $authorId | CreatedAt: $createdAt | PostId: $postId)))]]]";
}
