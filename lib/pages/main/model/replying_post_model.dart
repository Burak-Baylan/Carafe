class ReplyingPostModel {
  String replyingPostId;
  String replyingUserId;
  String? replyingUserToken;
  ReplyingPostModel({
    required this.replyingPostId,
    required this.replyingUserId,
    this.replyingUserToken,
  });
}
