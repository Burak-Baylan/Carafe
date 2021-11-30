import 'package:Carafe/core/firebase/base/firebase_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseManager extends FirebaseBase {
  static FirebaseManager? _instance;
  static FirebaseManager get instance =>
      _instance = _instance == null ? FirebaseManager._init() : _instance!;
  FirebaseManager._init();

  increaseField({
    required int count,
    required DocumentReference documentReference,
    required String fieldName,
  }) {
    firebaseService.updateValue(count, documentReference, fieldName);
  }

  decraseField({
    required int count,
    required DocumentReference documentReference,
    required String fieldName,
  }) {
    if (count > 0) {
      count = count - (count * 2);
    } else if (count == 0) {
      count = -1;
    }
    firebaseService.updateValue(count, documentReference, fieldName);
  }
}
