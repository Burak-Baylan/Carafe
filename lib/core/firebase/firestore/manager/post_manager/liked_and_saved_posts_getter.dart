import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../pages/main/model/like_model.dart';
import '../../../../../pages/main/model/post_model.dart';
import '../../../../../pages/main/model/post_save_model.dart';
import '../../../../../pages/main/sub_views/users_list_view/view_model/users_list_view_model.dart';
import '../../../base/firebase_base.dart';

class LikedAndSavedPostsGetter extends FirebaseBase {
  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisibleLikedPost;
  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisibleSavedPost;
  late Query<Map<String, dynamic>> userLikedPostsRef;
  late Query<Map<String, dynamic>> userSavedPostsRef;

  Future<List<PostModel>?> getPosts({
    required Query<Map<String, dynamic>> reference,
    required ListingType listingType,
  }) async {
    var rawLikedPosts = await firestoreService.getQuery(reference);
    if (rawLikedPosts.error != null || rawLikedPosts.data == null) {
      return null;
    }
    return await getPostsList(rawLikedPosts.data!.docs, listingType);
  }

  Future<List<PostModel>?> loadMorePosts({
    required Query<Map<String, dynamic>> reference,
    required QueryDocumentSnapshot<Map<String, dynamic>> lastVisiblePost,
    required ListingType listingType,
  }) async {
    var rawRef = reference.startAfterDocument(lastVisiblePost);
    var rawLikedPosts = await firestoreService.getQuery(rawRef);
    if (rawLikedPosts.error != null || rawLikedPosts.data == null) {
      return null;
    }
    return await getPostsList(rawLikedPosts.data!.docs, listingType);
  }

  Future<List<PostModel>?> getLikedPosts(
    Query<Map<String, dynamic>> userLikedPostsRef,
  ) async {
    this.userLikedPostsRef = userLikedPostsRef;
    var likedPosts = await getPosts(
      reference: userLikedPostsRef,
      listingType: ListingType.likes,
    );
    return likedPosts;
  }

  Future<List<PostModel>?> getMoreLikedPosts() async {
    var posts = await loadMorePosts(
      reference: userLikedPostsRef,
      lastVisiblePost: lastVisibleLikedPost,
      listingType: ListingType.likes,
    );
    return posts;
  }

  Future<List<PostModel>?> getSavedPosts(
    Query<Map<String, dynamic>> userSavedPostsRef,
  ) async {
    this.userSavedPostsRef = userSavedPostsRef;
    var likedPosts = await getPosts(
      reference: userSavedPostsRef,
      listingType: ListingType.savedPosts,
    );
    return likedPosts;
  }

  Future<List<PostModel>?> getMoreSavedPosts() async {
    var posts = await loadMorePosts(
      reference: userSavedPostsRef,
      lastVisiblePost: lastVisibleSavedPost,
      listingType: ListingType.savedPosts,
    );
    return posts;
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
