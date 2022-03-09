import 'package:Carafe/pages/main/model/post_save_model.dart';
import 'package:Carafe/pages/main/sub_views/users_list_view/view_model/users_list_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../pages/main/model/like_model.dart';
import '../../../../../pages/main/model/post_model.dart';
import '../../../base/firebase_base.dart';

class LikedAndSavedPostsGetter extends FirebaseBase {
  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisibleLikedPost;
  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisibleSavedPost;
  late Query<Map<String, dynamic>> userLikedPostsRef;
  late Query<Map<String, dynamic>> userSavedPostsRef;

  Future<List<PostModel>?> getLikedPosts(
    Query<Map<String, dynamic>> userLikedPostsRef,
  ) async {
    this.userLikedPostsRef = userLikedPostsRef;
    var rawLikedPosts = await firestoreService.getQuery(userLikedPostsRef);
    if (rawLikedPosts.error != null || rawLikedPosts.data == null) {
      return null;
    }
    return await getPostsList(rawLikedPosts.data!.docs, ListingType.likes);
  }

  Future<List<PostModel>?> getMoreLikedPosts() async {
    var rawLikedPosts = await firestoreService
        .getQuery(userLikedPostsRef.startAfterDocument(lastVisibleLikedPost));
    if (rawLikedPosts.error != null || rawLikedPosts.data == null) {
      return null;
    }
    return await getPostsList(rawLikedPosts.data!.docs, ListingType.likes);
  }

  //TODO ORGANIZE ET BURAYI
  Future<List<PostModel>?> getSavedPosts(
    Query<Map<String, dynamic>> userSavedPostsRef,
  ) async {
    this.userSavedPostsRef = userSavedPostsRef;
    var rawSavedPosts = await firestoreService.getQuery(userSavedPostsRef);
    if (rawSavedPosts.error != null || rawSavedPosts.data == null) {
      return null;
    }
    return await getPostsList(rawSavedPosts.data!.docs, ListingType.savedPosts);
  }

  Future<List<PostModel>?> getMoreSavedPosts() async {
    var rawSavedPosts = await firestoreService
        .getQuery(userSavedPostsRef.startAfterDocument(lastVisibleSavedPost));
    if (rawSavedPosts.error != null || rawSavedPosts.data == null) {
      return null;
    }
    return await getPostsList(rawSavedPosts.data!.docs, ListingType.savedPosts);
  }

  Future<List<PostModel>?> getPostsList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    ListingType listingType,
  ) async {
    List<PostModel> posts = [];
    int i = 0;
    for (var postsData in docs) {
      i++;
      String referencePath = getReferncePath(listingType, postsData.data());
      var rawData =
          await firestoreService.getDocument(firestore.doc(referencePath));
      if (rawData.error != null || rawData.data?.data() == null) {
        return null;
      }
      if (docs.length == i) {
        if (listingType == ListingType.likes) {
          lastVisibleLikedPost = docs[docs.length - 1];
        } else if (listingType == ListingType.savedPosts) {
          lastVisibleSavedPost = docs[docs.length - 1];
        }
      }
      var postModel =
          PostModel.fromJson(rawData.data!.data() as Map<String, dynamic>);
      posts.add(postModel);
    }
    return posts;
  }

  String getReferncePath(
    ListingType listingType,
    Map<String, dynamic> rawData,
  ) {
    if (listingType == ListingType.likes) {
      var likeModel = LikeModel.fromJson(rawData);
      return likeModel.likedPostRefPath;
    } else if (listingType == ListingType.savedPosts) {
      var savedPostModel = PostSaveModel.fromJson(rawData);
      return savedPostModel.sharedPostRef;
    }
    return '';
  }
}
