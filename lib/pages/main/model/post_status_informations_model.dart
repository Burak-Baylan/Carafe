class PostStatusInformationsModel {
  int views;
  int profileVisits;
  int interactions;
  int postClicks;

  PostStatusInformationsModel({
    required this.views,
    required this.profileVisits,
    required this.interactions,
    required this.postClicks,
  });

  factory PostStatusInformationsModel.fromJson(Map<String, dynamic> json) {
    return PostStatusInformationsModel(
      views: json['views'] as int,
      profileVisits: json['profile_visits'] as int,
      interactions: json['interactions'] as int,
      postClicks: json['post_clicks'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'views': views,
        'profile_visits': profileVisits,
        'interactions': interactions,
        'post_clicks': postClicks,
      };

  @override
  String toString() =>
      "[[[(((Views: $views | ProfileVisits: $profileVisits | Interactions: $interactions | PostClick: $postClicks)))]]]";
}
