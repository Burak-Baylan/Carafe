import 'package:Carafe/core/extensions/color_extensions.dart';
import 'package:Carafe/core/extensions/string_extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../app/constants/app_constants.dart';

class UserModel {
  String username;
  String email;
  String? photoUrl;
  String userId;
  String? profileDescription;
  Timestamp? createdAt;
  bool profilePrivacy;
  int followersCount;
  int followingCount;
  bool verified;
  Color profilePhotoBackgroundColor;
  bool notifications;

  UserModel({
    required this.userId,
    required this.email,
    this.username = "User",
    this.photoUrl,
    this.profileDescription,
    this.createdAt,
    this.profilePrivacy = false,
    this.followersCount = 0,
    this.followingCount = 0,
    this.verified = false,
    this.profilePhotoBackgroundColor = AppColors.black,
    this.notifications = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['uid'] as String,
      email: json['email'] as String,
      username: json["username"] as String,
      photoUrl: json['photo_url'] as String?,
      profileDescription: json['profile_description'] as String?,
      createdAt: json['created_at'] as Timestamp,
      profilePrivacy: json['profile_privacy'] as bool,
      followersCount: json['followers_count'] as int,
      followingCount: json['following_count'] as int,
      verified: json['verified'] as bool,
      profilePhotoBackgroundColor:
          (json['profile_photo_background_color'] as String)
              .convertStringToColor,
      notifications: json['notifications'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': userId,
        'email': email,
        'username': username,
        'photo_url': photoUrl,
        'profile_description': profileDescription,
        'created_at': createdAt,
        'profile_privacy': profilePrivacy,
        'followers_count': followersCount,
        'following_count': followingCount,
        'verified': verified,
        'profile_photo_background_color': profilePhotoBackgroundColor.getString,
        'notifications': notifications,
      };
}
