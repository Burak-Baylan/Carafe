import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../../../core/constants/firebase/firebase_constants.dart';
import '../../../../../../../../core/data/custom_data.dart';
import '../../../../../../../../core/firebase/auth/authentication/service/firebase_auth_service.dart';
import '../../../../../../../../core/firebase/firestore/manager/post_manager/post_manager.dart';
import '../../../../../../../../core/firebase/firestore/service/firebase_service.dart';
import '../../../../../../model/post_status_informatin_user_model.dart';

class PostStatusInformationsManager {
  FirebasePostManager postManager = FirebasePostManager.instance;
  FirebaseConstants firebaseConstants = FirebaseConstants.instance;
  FirebaseAuthService authService = FirebaseAuthService.instance;
  FirestoreService firestoreService = FirestoreService.instance;

  Future<void> addToPostViews(
    DocumentReference ref,
    Timestamp currentTime,
  ) async =>
      await addTo(firebaseConstants.postViewsText, ref, currentTime);

  Future<void> addToPostClicked(
    DocumentReference ref,
    Timestamp currentTime,
  ) async =>
      await addTo(firebaseConstants.postClicksText, ref, currentTime);

  Future<void> addToProfileVisits(
    DocumentReference ref,
    Timestamp currentTime,
  ) async =>
      await addTo(firebaseConstants.profileVisitsText, ref, currentTime);

  Future<void> addToInteractions(
    DocumentReference ref,
    Timestamp currentTime,
  ) async =>
      await addTo(firebaseConstants.interactionsText, ref, currentTime);

  Future<int> getPostViews(DocumentReference postRef) async {
    var data = await firestoreService
        .getCollection(postRef.collection(firebaseConstants.postViewsText));
    return _getCollectionSize(data);
  }

  Future<int> getPostClicked(DocumentReference postRef) async {
    var data = await firestoreService
        .getCollection(postRef.collection(firebaseConstants.postClicksText));
    return _getCollectionSize(data);
  }

  Future<int> getProfileVisits(DocumentReference postRef) async {
    var data = await firestoreService.getCollection(
      postRef.collection(firebaseConstants.profileVisitsText),
    );
    return _getCollectionSize(data);
  }

  Future<int> getInteractions(DocumentReference postRef) async {
    int postClickedCount = await getPostClicked(postRef);
    int profileVisitCount = await getProfileVisits(postRef);
    int likeCount = _getCollectionSize(await firestoreService
        .getCollection(postRef.collection(firebaseConstants.postLikersText)));
    int commentCount = _getCollectionSize(await firestoreService
        .getCollection(postRef.collection(firebaseConstants.postCommentsText)));
    return postClickedCount + likeCount + commentCount + profileVisitCount;
  }

  int _getCollectionSize(CustomData<QuerySnapshot<Map<String, dynamic>>> data) {
    if (data.error != null) {
      return 0;
    }
    return data.data!.size;
  }

  Future<void> addTo(
    String collectionName,
    DocumentReference ref,
    Timestamp currentTime,
  ) async =>
      await postManager.addToPostCollection(
        ref.collection(collectionName).doc(authService.userId!),
        PostStatusInformationUserModel(
          authorId: authService.userId!,
          viewedAt: currentTime,
        ).toJson(),
      );
}
