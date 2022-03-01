import 'package:cloud_firestore/cloud_firestore.dart';

class ReportedUserModel {
  Timestamp createdAt;
  String reportedUserId;
  String reporterUserId;
  String reportReason;
  String? reporterEmail;

  ReportedUserModel({
    required this.createdAt,
    required this.reportedUserId,
    required this.reporterUserId,
    required this.reportReason,
    this.reporterEmail,
  });

  factory ReportedUserModel.fromJson(Map<String, dynamic> json) {
    return ReportedUserModel(
      createdAt: json['created_at'],
      reportedUserId: json['reported_user_id'],
      reporterUserId: json['reporter_user_id'],
      reportReason: json[' report_reason'],
      reporterEmail: json['reporter_email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'reported_user_id': reportedUserId,
        'reporter_user_id': reporterUserId,
        'report_reason': reportReason,
        'reporter_email': reporterEmail,
      };

  @override
  String toString() => "[[[(((PostId: CreatedAt: {{{$createdAt}}}"
      "ReportedUserId: {{{$reportedUserId}}} | ReporterUserId: {{{$reporterUserId}}}"
      "ReportReason: {{{$reportReason}}} | ReporterEmail: {{{$reporterEmail}}})))]]]";
}
