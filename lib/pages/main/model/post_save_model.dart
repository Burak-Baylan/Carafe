import 'package:cloud_firestore/cloud_firestore.dart';

class PostSaveModel {
  Timestamp savedAt;
  String userId;
  String postId;
  String sharedPostRef;

  PostSaveModel({
    required this.savedAt,
    required this.userId,
    required this.postId,
    required this.sharedPostRef,
  });

  factory PostSaveModel.fromJson(Map<String, dynamic> json) {
    return PostSaveModel(
        savedAt: json['saved_at'],
        userId: json['user_id'],
        postId: json['postId'],
        sharedPostRef: json['shared_post_reference']);
  }

  Map<String, dynamic> toJson() => {
        'saved_at': savedAt,
        'user_id': userId,
        'postId': postId,
        'shared_post_reference': sharedPostRef,
      };

  @override
  String toString() =>
      "[[[(((PostId: SavedAt: {{{$savedAt}}} | UserId: {{{$userId}}} | PostId: {{{$postId}}} | Reference: {{{$sharedPostRef}}})))]]]";
}
