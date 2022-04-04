import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../core/constants/firebase/firebase_constants.dart';
import '../../../../../../core/firebase/firestore/service/firebase_service.dart';
import '../../../../../authenticate/model/follow_user_model.dart';
import '../../../../../authenticate/model/user_model.dart';
import '../../../../model/like_model.dart';
import '../../../../model/post_model.dart';
import '../users_list_view_model.dart';

class UsersListManager {
  static UsersListManager get instance => UsersListManager();

  final FirebaseConstants _firebaseConstants = FirebaseConstants.instance;
  final FirestoreService _firebaseService = FirestoreService.instance;

  List<PostModel> postModel = [];

  late QueryDocumentSnapshot<Map<String, dynamic>> _lastVisibleUserDoc;
  late ListingType _userListType;
  late Query<Map<String, dynamic>> _reference;

  Future<List<UserModel>?> getData({
    required ListingType userListType,
    required Query<Map<String, dynamic>> reference,
  }) async {
    _userListType = userListType;
    _reference = reference;
    return getter(getReference);
  }

  Future<List<UserModel>?> loadMore() async =>
      await getter(getReference.startAfterDocument(_lastVisibleUserDoc));

  Future<List<UserModel>?> getter(Query<Map<String, dynamic>> reference) async {
    var rawData = await _firebaseService.getQuery(reference);
    if (rawData.error != null || rawData.data == null) {
      return null;
    }
    var docs = rawData.data!.docs;
    List<UserModel>? usersList = [];
    for (var doc in docs) {
      var documentData = doc.data();
      String? userId = _getUserId(documentData);
      var userRef = _firebaseConstants.allUsersCollectionRef.doc(userId);
      var userRawData = await _firebaseService.getDocument(userRef);
      if (userRawData.error != null || userRawData.data == null) {
        continue;
      }
      if (doc == docs.last) {
        _lastVisibleUserDoc = doc;
      }
      var userModel =
          UserModel.fromJson(userRawData.data!.data() as Map<String, dynamic>);
      usersList.add(userModel);
    }
    return usersList;
  }

  String _getUserId(Map<String, dynamic> documentData) {
    if (_userListType == ListingType.likes) {
      var model = LikeModel.fromJson(documentData);
      return model.authorId;
    } else if (_userListType == ListingType.comments) {
      var model = PostModel.fromJson(documentData);
      postModel.add(model);
      return model.authorId;
    } else if (_userListType == ListingType.followingUsers) {
      var model = FollowUserModel.fromJson(documentData);
      return model.followingUserId;
    } else if (_userListType == ListingType.followerUsers) {
      var model = FollowUserModel.fromJson(documentData);
      return model.followerUserId;
    }
    return '';
  }

  Query<Map<String, dynamic>> get getReference => _reference
      .limit(_firebaseConstants.numberOfUsersSearchAtOnce)
      .orderBy(_getReferenceText, descending: true);

  String get _getReferenceText {
    var createdAtText = _firebaseConstants.createdAtText;
    var followedAtText = _firebaseConstants.followedAtText;
    var savedAtText = _firebaseConstants.savedAtText;
    switch (_userListType) {
      case (ListingType.likes):
        return createdAtText;
      case ListingType.comments:
        return createdAtText;
      case ListingType.search:
        // TODO: Handle this case.
        break;
      case ListingType.followingUsers:
        return followedAtText;
      case ListingType.followerUsers:
        return followedAtText;
      case ListingType.savedPosts:
        // TODO: Handle this case.
        break;
    }
    return createdAtText;
  }
}
