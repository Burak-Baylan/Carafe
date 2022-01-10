import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/constants/app_constants.dart';

class PostModel {
  String postId;
  String? text;
  String authorId;
  Timestamp? createdAt;
  int likeCount;
  int commentCount;
  String category;
  List<dynamic> imageLinks;
  List<dynamic> imagesDominantColors;
  bool postNotifications;
  bool? replyed;
  String? replyedPostId;
  String? replyedUserId;

  PostModel({
    required this.postId,
    required this.authorId,
    required this.imageLinks,
    required this.imagesDominantColors,
    this.postNotifications = true,
    this.text,
    this.createdAt,
    this.likeCount = 0,
    this.commentCount = 0,
    this.category = PostContstants.ALL,
    this.replyed = false,
    this.replyedPostId,
    this.replyedUserId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      authorId: json['author_id'] as String,
      category: json['category'] as String,
      commentCount: json['comment_count'] as int,
      createdAt: json['created_at'] as Timestamp,
      imageLinks: json['image_links'] as List<dynamic>,
      imagesDominantColors: json['images_dominant_color'] as List<dynamic>,
      likeCount: json['like_count'] as int,
      postId: json['postId'] as String,
      text: json['text'] as String?,
      postNotifications: json['post_notifications'] as bool,
      replyed: json['replyed'] as bool?,
      replyedPostId: json['replyed_postId'] as String?,
      replyedUserId: json['replyed_userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'author_id': authorId,
        'category': category,
        'comment_count': commentCount,
        'created_at': createdAt,
        'image_links': imageLinks,
        'images_dominant_color': imagesDominantColors,
        'like_count': likeCount,
        'postId': postId,
        'text': text,
        'post_notifications': postNotifications,
        'replyed': replyed,
        'replyed_postId' : replyedPostId,
        'replyed_userId' : replyedUserId,
      };

  @override
  String toString() =>
      "[[[(((PostId: $postId | Text: $text | AuthorId: $authorId | CreatedAt: $createdAt | LikeCount: $likeCount | CommentCount: $commentCount" +
      "| ImageLinks: {{{$imageLinks}}} | ImageDominantColors: {{{$imagesDominantColors}}} | PostNotifications: $postNotifications)))]]]";
}
