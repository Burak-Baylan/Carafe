import 'package:cloud_firestore/cloud_firestore.dart';

class PinnedPostModel {
  String authorId;
  String postId;
  String pinnedPostPath;
  Timestamp createdAt;

  PinnedPostModel({
    required this.authorId,
    required this.postId,
    required this.createdAt,
    required this.pinnedPostPath,
  });

  factory PinnedPostModel.fromJson(Map<String, dynamic> json) {
    return PinnedPostModel(
      authorId: json['author_id'] as String,
      postId: json['postId'] as String,
      pinnedPostPath: json['pinned_post_path'] as String,
      createdAt: json['created_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'author_id': authorId,
        'postId': postId,
        'created_at': createdAt,
        'pinned_post_path': pinnedPostPath,
      };

  @override
  String toString() =>
      "[[[(((AuthorId: $authorId | CreatedAt: $createdAt | PostId: $postId | PinnedPostPath: $pinnedPostPath)))]]]";
}
