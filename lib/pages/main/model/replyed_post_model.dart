import 'package:Carafe/pages/authenticate/model/user_model.dart';
import 'package:Carafe/pages/main/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReplyedPostModel {
  PostModel? replyingPostModel;
  UserModel? replyingUserModel;
  DocumentReference? parentPostRef;
  ReplyedPostModel({
    required this.replyingPostModel,
    required this.replyingUserModel,
    required this.parentPostRef,
  });
}
