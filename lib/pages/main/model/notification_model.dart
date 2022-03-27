import '../../../main.dart';

class NotificationModel {
  NotificationModel({
    required this.senderToken,
    required this.senderUserId,
    required this.postId,
    required this.type,
    required this.receiverToken,
    required this.receiverUserId,
    required this.postPath,
    required this.notificationId,
    this.title,
    this.message,
    this.hasRead = false,
    this.createdAt,
  }) {
    createdAt = mainVm.currentTime.toDate().toString();
  }

  String? senderToken;
  String? senderUserId;
  String? postId;
  String? type;
  String? receiverToken;
  String? receiverUserId;
  String? postPath;
  String? title;
  String? message;
  String notificationId;
  String? createdAt;
  bool hasRead;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    bool getHasReadValue(Object data) {
      if (data == 'true' || data == true) {
        return true;
      }
      return false;
    }

    return NotificationModel(
      senderToken: json['sender_token'],
      senderUserId: json['sender_user_id'],
      postId: json['post_id'],
      type: json['type'],
      receiverToken: json['receiver_token'],
      receiverUserId: json['receiver_user_id'],
      postPath: json['post_path'],
      title: json['title'],
      message: json['message'],
      hasRead: getHasReadValue(json['has_read']),
      notificationId: json['notification_id'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'priority': 'high',
        'sender_token': senderToken,
        'sender_user_id': senderUserId,
        'post_id': postId,
        'type': type,
        'receiver_token': receiverToken,
        'receiver_user_id': receiverUserId,
        'post_path': postPath,
        'title': title,
        'message': message,
        'has_read': hasRead,
        'notification_id': notificationId,
        'created_at': createdAt,
      };
}
