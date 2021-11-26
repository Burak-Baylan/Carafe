import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? email;
  String? username;
  String? profilePhotoUrl;
  User? user;

  UserModel({this.user, this.email, this.username, this.profilePhotoUrl});
}
