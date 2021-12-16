import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../app/constants/app_constants.dart';

class UserModel {
  User user;
  String? profileDescription;
  Timestamp? createdAt;
  bool profilePrivacy;
  int followersCount;
  int followingCount;
  bool verified;
  Color profilePhotoBackgroundColor;
  bool notifications;

  UserModel({
    required this.user,
    this.profileDescription,
    this.createdAt,
    this.profilePrivacy = false,
    this.followersCount = 0,
    this.followingCount = 0,
    this.verified = false,
    this.profilePhotoBackgroundColor = AppColors.black,
    this.notifications = true,
  });
}
