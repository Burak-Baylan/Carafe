import 'package:Carafe/core/firebase/base/firebase_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService extends FirebaseBase {
  static FirebaseService? _instance;
  static FirebaseService get instance =>
      _instance = _instance == null ? FirebaseService._init() : _instance!;
  FirebaseService._init();

  updateValue(
    int value,
    DocumentReference documentReference,
    String fieldName,
  ) {
    var increment = _increaser(value);
    WriteBatch batch = firestore.batch();
    batch.update(documentReference, {fieldName: increment});
    batch.commit();
  }

  FieldValue _increaser(int value) => FieldValue.increment(value);
}
