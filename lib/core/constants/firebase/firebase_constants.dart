import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase/base/firebase_base.dart';

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
  String deletedPostsText = "deleted_posts";
  String postLikersText = "likes";
  String usersText = "Users";
  String userSavedPostsText = "saved_posts";
  String userIdText = 'userId';
  String followingText = 'following';
  String followersText = 'followers';
  String followerUserText = 'follower_user';
  String followingUserText = 'following_user';
  String pinnedPostText = 'pinned_post';
  String postCommentsText = 'comments';
  String usernameText = 'username';
  String usernameLowerCaseText = 'username_lower_case';
  String postViewsText = 'post_views';
  String postClicksText = 'post_clicks';
  String profileVisitsText = 'profile_visits';
  String interactionsText = 'interactions';
  String isPostDeletedText = 'is_post_deleted';
  String displayNameText = 'display_name';
  String profileDescriptionText = 'profile_description';
  String websiteText = 'website';
  String birthDateText = 'birth_date';
  String hasImageText = 'has_image';
  String ppUrlText = 'photo_url';
  String followedAtText = 'followed_at';
  String reportedUsersText = 'ReportedUsers';
  String reportedPostsText = 'ReportedPosts';
  String categoryText = 'category';
  String feedbacksText = 'Feedback';
  String savedAtText = 'saved_at';

  int numberOfPostsToBeReceiveAtOnce = 15;
  int numberOfCommentsToBeReceiveAtOnce = 6;
  int numberOfUsersSearchAtOnce = 10;

  @override
  CollectionReference<Map<String, dynamic>> get allUsersCollectionRef =>
      firestore.collection(usersText);
  @override
  CollectionReference<Map<String, dynamic>> get allPostsCollectionRef =>
      firestore.collection(postsText);

  @override
  DocumentReference<Map<String, dynamic>> userDocRef(String userId) =>
      allUsersCollectionRef.doc(userId);
  @override
  DocumentReference<Map<String, dynamic>> postDocRef(String postId) =>
      allPostsCollectionRef.doc(postId);

  CollectionReference<Map<String, dynamic>> allCommentsCollectionRef(
          String postId) =>
      firestore.collection(postsText).doc(postId).collection(postCommentsText);

  CollectionReference<Map<String, dynamic>> postLikesCollectionRef(
          DocumentReference docRef) =>
      docRef.collection(postLikersText);

  CollectionReference<Map<String, dynamic>>
      get currentUserLikedPostsCollectionRef => allUsersCollectionRef
          .doc(authService.userId)
          .collection(postLikersText);

  CollectionReference<Map<String, dynamic>> userLikedPostsCollectionRef(
          String userId) =>
      allUsersCollectionRef.doc(userId).collection(postLikersText);

  Query<Map<String, dynamic>> userLikedPostsCollectionRefWithLimitAndDescending(
          String userId) =>
      userLikedPostsCollectionRef(userId)
          .orderBy(firebaseConstants.createdAtText, descending: true)
          .limit(firebaseConstants.numberOfPostsToBeReceiveAtOnce);

  CollectionReference<Map<String, dynamic>> userPostSaveCollectionRef(
          String userId) =>
      allUsersCollectionRef.doc(userId).collection(userSavedPostsText);

  Query<Map<String, dynamic>> get postsCreatedDescending =>
      allPostsCollectionRef.orderBy(createdAtText, descending: true);

  Query<Map<String, dynamic>> get postsCreatedAscending =>
      allPostsCollectionRef.orderBy(createdAtText, descending: false);

  Query<Map<String, dynamic>> commentsCreatedDescending(
          CollectionReference<Map<String, dynamic>> collectionRef) =>
      collectionRef.orderBy(createdAtText, descending: true);

  Query<Map<String, dynamic>> commentsCreatedAscending(String postId) =>
      allCommentsCollectionRef(postId)
          .orderBy(createdAtText, descending: false);

  Query<Map<String, dynamic>> userPinnedPostControlRef(
          String currentUserId, String postId) =>
      allUsersCollectionRef
          .doc(currentUserId)
          .collection(pinnedPostText)
          .where(postIdText, isEqualTo: postId);

  DocumentReference<Map<String, dynamic>> userPinnedPostDocRef(String userId) =>
      allUsersCollectionRef.doc(userId).collection(pinnedPostText).doc(userId);

  CollectionReference<Map<String, dynamic>> userPinnedPostCollectionRef(
          String userId) =>
      allUsersCollectionRef.doc(userId).collection(pinnedPostText);

  Query<Map<String, dynamic>> userFollowingControlRef(
    String currentUserId,
    String postOwnerUserId,
  ) =>
      userFollowingCollectionRef(currentUserId)
          .where(followingUserText, isEqualTo: postOwnerUserId);

  Query<Map<String, dynamic>> userLikeStatusPath(
    DocumentReference docRef,
    String userId,
  ) =>
      docRef.collection(postLikersText).where(authorIdText, isEqualTo: userId);

  Query<Map<String, dynamic>> userSaveStatusPath(
    String postId,
    String userId,
  ) =>
      userPostSaveCollectionRef(userId).where(postIdText, isEqualTo: postId);

  CollectionReference<Map<String, dynamic>> userFollowersCollectionRef(
          String userId) =>
      allUsersCollectionRef.doc(userId).collection(followersText);

  CollectionReference<Map<String, dynamic>> userFollowingCollectionRef(
          String userId) =>
      allUsersCollectionRef.doc(userId).collection(followingText);

  Stream<QuerySnapshot<Map<String, dynamic>>> likeCountStremRef(
          DocumentReference docRef) =>
      docRef.collection(postLikersText).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> commentsStremRef(
          DocumentReference postRef) =>
      postRef
          .collection(postCommentsText)
          .where(isPostDeletedText, isEqualTo: false)
          .snapshots();

  Query<Map<String, dynamic>> allUndeletedCommentsCollection(
          DocumentReference postRef) =>
      postRef
          .collection(postCommentsText)
          .where(isPostDeletedText, isEqualTo: false);

  Query<Map<String, dynamic>> getCommentsWithLimit(
          CollectionReference<Map<String, dynamic>> commentsRef) =>
      commentsCreatedDescending(commentsRef)
          .limit(numberOfCommentsToBeReceiveAtOnce);

  Query<Map<String, dynamic>> getCommentsWithLimitStartAfterDocumentsRef(
          QueryDocumentSnapshot<Map<String, dynamic>> lastVisibleComment,
          DocumentReference<Object?> postCommentsRef) =>
      commentsCreatedDescending(
              postCommentsRef.collection(firebaseConstants.postCommentsText))
          .startAfterDocument(lastVisibleComment)
          .where(isPostDeletedText, isEqualTo: false)
          .limit(firebaseConstants.numberOfCommentsToBeReceiveAtOnce);

  Query<Map<String, dynamic>> getAUsersPostRef(String userId) =>
      allPostsCollectionRef
          .where(isPostDeletedText, isEqualTo: false)
          .where(authorIdText, isEqualTo: userId)
          .orderBy(createdAtText, descending: true)
          .limit(numberOfPostsToBeReceiveAtOnce);

  Query<Map<String, dynamic>> aPostCommentsRef(String postPath) =>
      firestore.doc(postPath).collection(postCommentsText);

  CollectionReference<Map<String, dynamic>> aPostLikesRef(String postPath) =>
      firestore.doc(postPath).collection(postLikersText);

  Query<Map<String, dynamic>> aUsersMediaPostsRef(String userId) =>
      getAUsersPostRef(userId).where(hasImageText, isEqualTo: true);

  Query<Map<String, dynamic>> getUserSearchQueryWithLimit(String text) =>
      allUsersCollectionRef
          .orderBy(firebaseConstants.usernameLowerCaseText)
          .startAt([text]).endAt([text + '\uf8ff']).limit(
              numberOfUsersSearchAtOnce);

  CollectionReference<Map<String, dynamic>> get reportedUsersCollection =>
      firestore.collection(reportedUsersText);

  CollectionReference<Map<String, dynamic>> get reportedPostsCollection =>
      firestore.collection(reportedPostsText);

  CollectionReference<Map<String, dynamic>> get feedbackCollectionRef =>
      firestore.collection(feedbacksText);

  Query<Map<String, dynamic>>
      get getCurrentUserSavedPostWithLimitAndDescending =>
          firebaseConstants.allUsersCollectionRef
              .doc(authService.userId)
              .collection(firebaseConstants.userSavedPostsText)
              .orderBy(firebaseConstants.savedAtText, descending: true)
              .limit(firebaseConstants.numberOfPostsToBeReceiveAtOnce);
}
