import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  Timestamp createdAt;
  String feedbackMessage;
  String userId;

  FeedbackModel({
    required this.createdAt,
    required this.feedbackMessage,
    required this.userId,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      createdAt: json['created_at'],
      feedbackMessage: json['feedback_message'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'feedback_message': feedbackMessage,
        'user_id': userId,
      };

  @override
  String toString() => "[[[(((PostId: CreatedAt: {{{$createdAt}}}"
      "FeedbackMessage: {{{$feedbackMessage}}} | UserId: {{{$userId}}}";
}
