import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseBase{
   FirebaseAuth get auth => FirebaseAuth.instance;
   FirebaseFirestore get firestore => FirebaseFirestore.instance;
   FirebaseStorage get storage => FirebaseStorage.instance;
}