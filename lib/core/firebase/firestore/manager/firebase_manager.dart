import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../pages/authenticate/model/user_model.dart';
import '../../../../pages/main/model/post_model.dart';
import '../../../error/custom_error.dart';
import '../../base/firebase_base.dart';

class FirebaseManager extends FirebaseBase {
  static FirebaseManager? _instance;
  static FirebaseManager get instance =>
      _instance = _instance == null ? FirebaseManager._init() : _instance!;
  FirebaseManager._init();

  Future increaseField({
    int count = 1,
    required DocumentReference documentReference,
    required String fieldName,
  }) async =>
      await firebaseService.updateValue(count, documentReference, fieldName);

  Future decraseField({
    int count = -1,
    required DocumentReference documentReference,
    required String fieldName,
  }) async {
    if (count > 0) {
      count = count - (count * 2);
    } else if (count == 0) {
      count = -1;
    }
    await firebaseService.updateValue(count, documentReference, fieldName);
  }

  Future<PostModel?> getPostInformations(
    String? postId, {
    DocumentReference? reference,
  }) async {
    var rawData = await firebaseService
        .getDocument(reference ?? postDocRef(postId!));
    if (rawData.error != null) return null;
    var data = rawData.data!.data() as Map<String, dynamic>;
    return PostModel.fromJson(data);
  }

  Future<UserModel?> getAUserInformation(String userId) async {
    var data = await getADocument(userDocRef(userId));
    return data == null ? null : UserModel.fromJson(data);
  }

  Future<UserModel?> get getCurrentUserInformations async =>
      await getAUserInformation(authService.userId!);

  Future<Map<String, dynamic>?> getADocument(
    DocumentReference<Object?> reference,
  ) async {
    var rawData = await firebaseService.getDocument(reference);
    if (rawData.error != null) return null;
    var data = rawData.data!.data() as Map<String, dynamic>;
    return data;
  }

  Future<int?> get followersCount async =>
      (await getCurrentUserInformations)?.followersCount;

  Future<int?> get followingCount async =>
      (await getCurrentUserInformations)?.followingCount;

  Future<CustomError> update(
          DocumentReference ref, Map<String, dynamic> data) async =>
      await firebaseService.updateDocument(ref, data);
}
