import 'package:flutter/material.dart';

import '../../../../../../core/error/custom_error.dart';
import '../../../../../../core/extensions/color_extensions.dart';
import '../../../../model/post_model.dart';
import '../add_post_view_model.dart';

class SharePost {
  static SharePost? _instance;
  static SharePost get instance =>
      _instance = _instance == null ? SharePost._init() : _instance!;
  SharePost._init();

  late AddPostViewModel vm;
  String postId = "";
  List<String> imageLinks = [];
  List<String> imagesDominantColors = [];

  Future<CustomError> share(AddPostViewModel viewModel) async {
    vm = viewModel;
    imageLinks = [];
    imagesDominantColors = [];
    postId = "";
    postId = vm.getRandomId;
    await _uploadImages();
    await _getImagesDominantColors();
    PostModel postModel = _prepareModel(postId);
    var response = await _uploadPost(postId, postModel);
    return response;
  }

  Future<CustomError> _uploadPost(String postId, PostModel model) async =>
      await vm.firestoreService
          .addDocument(vm.firestore.collection("posts").doc(postId), {
        'postId': model.postId,
        'text': model.text,
        'author_id': model.authorId,
        'created_at': model.createdAt,
        'like_count': model.likeCount,
        'comment_count': model.commentCount,
        'category': model.category,
        'image_links': model.imageLinks,
        'images_dominant_color': imagesDominantColors,
        'post_notifications': model.postNotifications,
      });

  PostModel _prepareModel(String postId) => PostModel(
        postId: postId,
        authorId: vm.authService.auth.currentUser!.uid,
        imageLinks: imageLinks,
        imagesDominantColors: imagesDominantColors,
        text: vm.postText,
        createdAt: vm.currentTime,
        likeCount: 0,
        commentCount: 0,
        category: vm.selectedCategory,
        postNotifications: true,
      );

  Future<CustomError> _uploadImages() async {
    List<String> imagePaths = [];
    CustomError response = CustomError(null);
    String folderPath = _createPath;
    for (var i = 0; i < vm.images.length; i++) {
      var image = vm.images[i];
      if (image != null) {
        String imageId = vm.getRandomId;
        String path = "$folderPath/$imageId";
        response = await vm.storageService.upload(path, image);
        imagePaths.add(folderPath);
        if (response.errorMessage != null) {
          await _deletePreviousPhotos(imagePaths);
          return response;
        }
        String? imageLink = await vm.storageService.getDownloadUrl(path);
        if (imageLink == null) {
          await _deletePreviousPhotos(imagePaths);
          return CustomError("Somethings went wrong. Please try again.");
        }
        imageLinks.add(imageLink);
      }
    }
    return response;
  }

  Future _getImagesDominantColors() async {
    for (var element in vm.images) {
      if (element == null) {
        imagesDominantColors.add(Colors.black.getString);
        continue;
      }
      Color? color = await vm.getDominantColor(element);
      if (color == null) {
        imagesDominantColors.add(Colors.black.getString);
        continue;
      }
      imagesDominantColors.add(color.getString);
    }
  }

  Future _deletePreviousPhotos(List<String> paths) async {
    for (var i = 0; i < paths.length; i++) {
      var path = paths[i];
      await vm.storageService.delete(path);
    }
    imageLinks = [];
  }

  String get _createPath {
    String userId = vm.authService.auth.currentUser!.uid;
    return "users/$userId/post/$postId/images";
  }
}
