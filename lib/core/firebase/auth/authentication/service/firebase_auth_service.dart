import 'package:Carafe/core/error/custom_error.dart';
import 'package:Carafe/core/firebase/auth/authentication/response/authentication_response.dart';
import 'package:Carafe/core/firebase/auth/authentication/service/base/base_authentication.dart';
import 'package:Carafe/view/authenticate/view/login/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService extends BaseAuthentication{
  static FirebaseAuthService? _instance;
  static FirebaseAuthService get instance =>
      _instance = _instance == null ? FirebaseAuthService._init() : _instance!;
  FirebaseAuthService._init();

  Future<AuthnenticationResponse> login(LoginModel loginModel) async {
    try {
      UserCredential? userCredential =
          await auth.signInWithEmailAndPassword(
        email: loginModel.email!,
        password: loginModel.password!,
      );
      return AuthnenticationResponse(null, userCredential.user);
    } on FirebaseException catch (e) {
      return AuthnenticationResponse(CustomError(e.message), null);
    }
  }

  Future<AuthnenticationResponse> signup(LoginModel loginModel) async {
    try {
      UserCredential? userCredential =
          await auth.createUserWithEmailAndPassword(
        email: loginModel.email!,
        password: loginModel.password!,
      );  
      return AuthnenticationResponse(null, userCredential.user);
    } on FirebaseException catch (e) {
      return AuthnenticationResponse(CustomError(e.message), null);
    }
  }
}