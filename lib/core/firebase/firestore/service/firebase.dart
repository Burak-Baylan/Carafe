import 'package:Carafe/core/firebase/base/firebase_base.dart';

class FirebaseService extends FirebaseBase{
  static FirebaseService? _instance;
  static FirebaseService get instance =>
      _instance = _instance == null ? FirebaseService._init() : _instance!;
  FirebaseService._init();
}
