import 'package:Carafe/core/firebase/base/firebase_base.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../../../../../core/error/custom_error.dart';
import '../../../../../../core/extensions/color_extensions.dart';
import '../../../../model/post_model.dart';
import '../add_post_view_model.dart';

class SharePost with FirebaseBase {
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
      await vm.firestoreService.addDocument(
        vm.firestore.collection(firebaseConstants.postsText).doc(postId),
        model.toJson(),
      );

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
      Color dominantColor =
          await vm.imageColorsGetter.findSuitableColor(element);
      imagesDominantColors.add(dominantColor.getString);
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
