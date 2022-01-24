import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../error/custom_error.dart';
import '../../base/firebase_base.dart';

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

  Future<CustomError> delete(String? path, {Reference? reference}) async {
    try {
      await (path != null ? storage.ref(path) : reference!).delete();
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
