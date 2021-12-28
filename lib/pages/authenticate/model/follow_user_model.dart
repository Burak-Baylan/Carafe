import 'package:cloud_firestore/cloud_firestore.dart';

class FollowUserModel{
  String followerUserId;
  String followingUserId;
  Timestamp? followedAt;

  FollowUserModel({
    required this.followerUserId,
    required this.followingUserId,
    this.followedAt,
  });

  factory FollowUserModel.fromJson(Map<String, dynamic> json) {
    return FollowUserModel(
      followerUserId: json['follower_user'] as String,
      followingUserId: json['following_user'] as String,
      followedAt: json['followed_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'follower_user': followerUserId,
        'following_user': followingUserId,
        'followed_at': followedAt,
  };
}