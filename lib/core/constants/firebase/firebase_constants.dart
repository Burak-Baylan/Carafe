import 'package:Carafe/core/firebase/base/firebase_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConstants extends FirebaseBase {
  static FirebaseConstants? _instance;
  static FirebaseConstants get instance =>
      _instance = _instance == null ? FirebaseConstants._init() : _instance!;
  FirebaseConstants._init();

  //* Post paths
  String postsText = "posts";
  String commentCountText = "comment_count";
  String createdAtText = "created_at";
  String imageLinksText = "image_links";
  String imageDominantColorsText = "image_dominant_color";
  String likeCountText = "like_count";
  String postIdText = "postId";
  String postNotificationsText = "post_notifications";
  String textText = "text";
  String authorIdText = "author_id";
  String followersCount = "followers_count";
  //*

  String collectionLikesText = "likers";
  String postLikersText = "likes";
  String usersText = "Users";

  int numberOfPostsToBeUploadedAtOnce = 15;

  @override
  DocumentReference<Map<String, dynamic>> userDocRef(String userId) =>
      allUsersCollectionRef.doc(userId);
  @override
  DocumentReference<Map<String, dynamic>> postDocRef(String postId) =>
      allPostsCollectionRef.doc(postId);

  CollectionReference<Map<String, dynamic>> postLikesCollectionRef(
          String postId) =>
      allPostsCollectionRef.doc(postId).collection(postLikersText);

  @override
  CollectionReference<Map<String, dynamic>> get allUsersCollectionRef =>
      firestore.collection(usersText);
  @override
  CollectionReference<Map<String, dynamic>> get allPostsCollectionRef =>
      firestore.collection(postsText);

  Query<Map<String, dynamic>> get postsCreatedDescending =>
      allPostsCollectionRef.orderBy(createdAtText, descending: true);

  Query<Map<String, dynamic>> get postsCreatedAscending =>
      allPostsCollectionRef.orderBy(createdAtText, descending: false);

  Query<Map<String, dynamic>> userLikeStatusPath(
    String postId,
    String userId,
  ) =>
      postLikesCollectionRef(postId).where(authorIdText, isEqualTo: userId);
}
