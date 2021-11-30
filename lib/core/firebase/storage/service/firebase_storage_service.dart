import 'dart:io';

import 'package:Carafe/core/error/custom_error.dart';
import 'package:Carafe/core/firebase/base/firebase_base.dart';
import 'package:Carafe/view/main/view/add_post/view_model/add_post_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStorageService extends FirebaseBase {
  static FirebaseStorageService? _instance;
  static FirebaseStorageService get instance => _instance =
      _instance == null ? FirebaseStorageService._init() : _instance!;
  FirebaseStorageService._init();

  //* users/userId/posts/postId/images
  //* users/userId/comments/commentId/images

  Future<CustomError> upload(String path, File image) async {
    try {
      await storage.ref(path).putFile(image);
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> delete(String path) async {
    try {
      await storage.ref(path).delete();
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<String?> getDownloadUrl(String path) async {
    try {
      return await storage.ref(path).getDownloadURL();
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
