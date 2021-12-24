import 'package:cloud_firestore/cloud_firestore.dart';

class PostSaveModel {
  Timestamp savedAt;
  String userId;
  String postId;

  PostSaveModel({
    required this.savedAt,
    required this.userId,
    required this.postId,
  });

  factory PostSaveModel.fromJson(Map<String, dynamic> json) {
    return PostSaveModel(
      savedAt: json['saved_at'],
      userId: json['user_id'],
      postId: json['postId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'saved_at': savedAt,
        'user_id': userId,
        'postId': postId,
      };

  @override
  String toString() =>
      "[[[(((PostId: SavedAt: {{{$savedAt}}} | UserId: {{{$userId}}} | PostId: $postId)))]]]";
}
