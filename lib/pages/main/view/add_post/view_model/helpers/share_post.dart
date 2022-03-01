import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/error/custom_error.dart';
import '../../../../../../core/extensions/color_extensions.dart';
import '../../../../../../core/firebase/base/firebase_base.dart';
import '../../../../../../core/helpers/random_id.dart';
import '../../../../model/post_model.dart';
import '../../../../model/replying_post_model.dart';
import '../add_post_view_model.dart';

class SharePost with FirebaseBase {
  static SharePost? _instance;
  static SharePost get instance =>
      _instance = _instance == null ? SharePost._init() : _instance!;
  SharePost._init();

  late AddPostViewModel addPostViewModel;
  String postId = "";
  List<String> imageLinks = [];
  List<String> imagesDominantColors = [];
  CollectionReference? postRef;
  ReplyingPostModel? replyingPostModel;

  Future<CustomError> share(
    AddPostViewModel viewModel, {
    CollectionReference? postRef,
    ReplyingPostModel? replyingPostModel,
  }) async {
    addPostViewModel = viewModel;
    imageLinks = [];
    imagesDominantColors = [];
    postId = getRandomId();
    this.replyingPostModel = replyingPostModel;
    this.postRef = postRef;
    var uploadResponse = await _uploadImages();
    if (uploadResponse.errorMessage != null) return uploadResponse;
    await _getImagesDominantColors();
    PostModel model = _prepareModel();
    var response = await _uploadPost(model);
    return response;
  }

  Future<CustomError> _uploadPost(PostModel model) async =>
      await firestoreService.addDocument(getUploadRef, model.toJson());

  DocumentReference<Object?> get getUploadRef =>
      postRef?.doc(postId) ?? allPostsCollectionRef.doc(postId);

  PostModel _prepareModel() => PostModel(
        postId: postId,
        authorId: authService.userId!,
        imageLinks: imageLinks,
        imagesDominantColors: imagesDominantColors,
        text: addPostViewModel.postText,
        createdAt: addPostViewModel.currentTime,
        likeCount: 0,
        commentCount: 0,
        category: addPostViewModel.selectedCategory,
        postNotifications: true,
        replyed: replyingPostModel?.replyingPostId != null ? true : false,
        replyedPostId: replyingPostModel?.replyingPostId,
        replyedUserId: replyingPostModel?.replyingUserId,
        isPostDeleted: false,
        hasImage: imageLinks.isNotEmpty,
        postPath: getUploadRef.path,
      );

  Future<CustomError> _uploadImages() async {
    List<String> imagePaths = [];
    CustomError response = CustomError(null);
    String folderPath = _createImageFolderPath;
    for (var image in addPostViewModel.images) {
      if (image != null) {
        String imageId = addPostViewModel.randomId;
        String path = "$folderPath/$imageId";
        response = await storageService.upload(path, image);
        imagePaths.add(folderPath);
        if (response.errorMessage != null) {
          await _deletePreviousPhotos(imagePaths);
          return response;
        }
        String? imageLink = await storageService.getDownloadUrl(path);
        if (imageLink == null) {
          await _deletePreviousPhotos(imagePaths);
          return CustomError("Somethings went wrong. Please try again.");
        }
        imageLinks.add(imageLink);
      }
    }
    return response;
  }

  Future<void> _getImagesDominantColors() async {
    for (var element in addPostViewModel.images) {
      if (element == null) {
        imagesDominantColors.add(Colors.black.getString);
        continue;
      }
      Color dominantColor =
          await addPostViewModel.imageColorsGetter.findSuitableColor(element);
      imagesDominantColors.add(dominantColor.getString);
    }
  }

  Future<void> _deletePreviousPhotos(List<String> paths) async {
    for (var i = 0; i < paths.length; i++) {
      var path = paths[i];
      await storageService.delete(path);
    }
    imageLinks = [];
  }

  String get _createImageFolderPath {
    String userId = authService.userId!;
    return "users/$userId/post/$postId/images";
  }
}
