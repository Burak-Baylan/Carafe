import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../pages/main/model/like_model.dart';
import '../../../../../pages/main/model/post_model.dart';
import '../../../base/firebase_base.dart';

class LikedPostsGetter extends FirebaseBase {
  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisibleLikedPost;
  late Query<Map<String, dynamic>> userLikedPostsRef;

  Future<List<PostModel>?> getLikedPosts(
    Query<Map<String, dynamic>> userLikedPostsRef,
  ) async {
    this.userLikedPostsRef = userLikedPostsRef;
    var rawLikedPosts = await firestoreService.getQuery(userLikedPostsRef);
    if (rawLikedPosts.error != null || rawLikedPosts.data == null) {
      return null;
    }
    return await getPostsList(rawLikedPosts.data!.docs);
  }

  Future<List<PostModel>?> getMoreLikedPosts() async {
    var rawLikedPosts = await firestoreService
        .getQuery(userLikedPostsRef.startAfterDocument(lastVisibleLikedPost));
    if (rawLikedPosts.error != null || rawLikedPosts.data == null) {
      return null;
    }
    return await getPostsList(rawLikedPosts.data!.docs);
  }

  Future<List<PostModel>?> getPostsList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) async {
    List<PostModel> likedPosts = [];
    int i = 0;
    for (var likedPostData in docs) {
      i++;
      var likeModel = LikeModel.fromJson(likedPostData.data());
      var rawLikedPost = await firestoreService
          .getDocument(firestore.doc(likeModel.likedPostRefPath));
      if (rawLikedPost.error != null || rawLikedPost.data?.data() == null) {
        return null;
      }
      if (docs.length == i) {
        lastVisibleLikedPost = docs[docs.length - 1];
      }
      var postModel =
          PostModel.fromJson(rawLikedPost.data!.data() as Map<String, dynamic>);
      likedPosts.add(postModel);
    }
    return likedPosts;
  }
}
