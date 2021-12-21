import 'package:Carafe/core/data/custom_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../error/custom_error.dart';
import '../../base/firebase_base.dart';

class FirestoreService extends FirebaseBase {
  static FirestoreService? _instance;
  static FirestoreService get instance =>
      _instance = _instance == null ? FirestoreService._init() : _instance!;
  FirestoreService._init();

  Future updateValue(
    int value,
    DocumentReference documentReference,
    String fieldName,
  ) async {
    var increment = _increaser(value);
    WriteBatch batch = firestore.batch();
    batch.update(documentReference, {fieldName: increment});
    await batch.commit();
  }

  FieldValue _increaser(int value) => FieldValue.increment(value);

  CustomData<E> getAField<E>(
    QueryDocumentSnapshot<Map<String, dynamic>> path,
    String fieldName,
  ){
    try {
      var data = path.get(fieldName);
      return CustomData<E>(data, null);
    } catch (e) {
      return CustomData<E>(null, CustomError(e.toString()));
    }
  }

  Future<CustomError> deleteDocument(DocumentReference reference) async {
    try {
      await reference.delete();
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> addDocument(
    DocumentReference reference,
    Object? data,
  ) async {
    try {
      await reference.set(data);
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> updateDocument(
      DocumentReference reference, Map<String, Object?> data) async {
    try {
      await reference.update(data);
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomData<DocumentSnapshot<Object?>>> getDocument(
      DocumentReference reference) async {
    try {
      var data = await reference.get();
      return CustomData(data, null);
    } on FirebaseException catch (e) {
      return CustomData(null, CustomError(e.message));
    }
  }
}
