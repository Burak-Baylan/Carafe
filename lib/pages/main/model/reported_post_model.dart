import 'package:cloud_firestore/cloud_firestore.dart';

class ReportedPostModel {
  Timestamp createdAt;
  String reportedPostRef;
  String reportedPostId;
  String reporterId;
  String reportedId;
  String reportReason;
  String? reporterEmail;

  ReportedPostModel({
    required this.createdAt,
    required this.reportedPostRef,
    required this.reportedPostId,
    required this.reporterId,
    required this.reportedId,
    required this.reportReason,
    this.reporterEmail,
  });

  factory ReportedPostModel.fromJson(Map<String, dynamic> json) {
    return ReportedPostModel(
      createdAt: json['created_at'],
      reportedPostRef: json['reported_post_ref'],
      reportedPostId: json['reported_post_id'],
      reporterId: json['reporter_id'],
      reportedId: json['reported_id'],
      reportReason: json[' report_reason'],
      reporterEmail: json['reporter_email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'reported_post_ref': reportedPostRef,
        'reported_post_id': reportedPostId,
        'reporter_id': reporterId,
        'reported_id': reportedId,
        'report_reason': reportReason,
        'reporter_email': reporterEmail,
      };

  @override
  String toString() =>
      "[[[(((PostId: CreatedAt: {{{$createdAt}}} | ReportedPostRef: {{{$reportedPostRef}}} | ReportedPostId: {{{$reportedPostId}}}"
      "ReporterId: {{{$reporterId}}} | ReportedId: {{{$reportedId}}} | ReportReason: {{{$reportReason}}} | ReporterEmail: {{{$reporterEmail}}})))]]]";
}
