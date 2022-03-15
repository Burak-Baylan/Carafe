import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorModel {
  String? userId;
  String? errorCode;
  String errorMessage;
  Timestamp createdAt;

  ErrorModel({
    required this.userId,
    required this.errorCode,
    required this.errorMessage,
    required this.createdAt,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      userId: json['user_id'] as String,
      errorCode: json['error_code'] as String,
      errorMessage: json['error_message'] as String,
      createdAt: json['created_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'error_code': errorCode,
        'error_message': errorMessage,
        'created_at': createdAt,
      };

  @override
  String toString() =>
      "[[[(((UserId: $userId | ErrorCode: $errorCode | ErrorMessage: $errorMessage | CretedAt: $createdAt)))]]]";
}
