import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class BaseView<T extends StatefulWidget> extends State<T> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String? userEmail;
  String? username;
  String? userUid;

  afterBuild(FrameCallback callback) => WidgetsBinding.instance!.addPostFrameCallback(callback);

  BaseView(){
    user = auth.currentUser;
    userEmail = user?.email;
    username = user?.displayName;
    userUid = user?.uid;
  }

}