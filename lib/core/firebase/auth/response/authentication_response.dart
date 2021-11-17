import 'package:Carafe/core/error/custom_error.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthnenticationResponse {
  CustomError? error;
  User? user;

  AuthnenticationResponse(this.error, this.user);
}
