import 'package:cloud_firestore/cloud_firestore.dart';

class LikeModel {
  String authorId;
  String postId;
  String likedPostRefPath;
  Timestamp createdAt;

  LikeModel({
    required this.authorId,
    required this.createdAt,
    required this.postId,
    required this.likedPostRefPath,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      authorId: json['author_id'] as String,
      likedPostRefPath: json['liked_post_ref'] as String,
      postId: json['post_id'] as String,
      createdAt: json['created_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'author_id': authorId,
        'post_id': postId,
        'created_at': createdAt,
        'liked_post_ref': likedPostRefPath,
      };

  @override
  String toString() =>
      "[[[(((AuthorId: $authorId | PostId: $postId | CreatedAt: $createdAt | LikedPostRef: $likedPostRefPath)))]]]";
}
