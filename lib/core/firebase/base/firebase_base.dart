import 'package:Carafe/core/firebase/firestore/manager/post_manager/like_manager.dart';
import 'package:Carafe/core/firebase/firestore/manager/post_manager/save_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../constants/firebase/firebase_constants.dart';
import '../auth/authentication/service/firebase_auth_service.dart';
import '../firestore/manager/firebase_manager.dart';
import '../firestore/manager/firebase_user_manager.dart';
import '../firestore/manager/post_manager/post_manager.dart';
import '../firestore/service/firebase_service.dart';
import '../storage/service/firebase_storage_service.dart';

abstract class FirebaseBase {
  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  FirebaseAuthService get authService => FirebaseAuthService.instance;
  FirebaseUserManager get userService => FirebaseUserManager.instance;
  FirestoreService get firestoreService => FirestoreService.instance;
  FirestoreService get firebaseService => FirestoreService.instance;
  FirebaseManager get firebaseManager => FirebaseManager.instance;
  FirebasePostManager get firebasePostManger => FirebasePostManager.instance;
  FirebaseStorageService get storageService => FirebaseStorageService.instance;
  FirebaseConstants get firebaseConstants => FirebaseConstants.instance;
  FirebasePostManager get postManager => FirebasePostManager.instance;
  PostLikeManager get postLikeManager => PostLikeManager.instance;
  PostSaveManager get postSaveManager => PostSaveManager.instance;

  CollectionReference get allUsersCollectionRef => firebaseConstants.allUsersCollectionRef;
  CollectionReference get allPostsCollectionRef => firebaseConstants.allPostsCollectionRef;
  userDocRef(String userId) => firebaseConstants.userDocRef(userId);
  postDocRef(String postId) => firebaseConstants.postDocRef(postId);

}
