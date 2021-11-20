import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthentication {
  FirebaseAuth auth = FirebaseAuth.instance;
}