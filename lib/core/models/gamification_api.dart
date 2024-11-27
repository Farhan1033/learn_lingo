class GamificationApi {
  int? level;
  int? currentExp;
  int? nextLevelExp;
  int? totalPoints;

  GamificationApi(
      {this.level, this.currentExp, this.nextLevelExp, this.totalPoints});

  GamificationApi.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    currentExp = json['current_exp'];
    nextLevelExp = json['next_level_exp'];
    totalPoints = json['total_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['current_exp'] = currentExp;
    data['next_level_exp'] = nextLevelExp;
    data['total_points'] = totalPoints;
    return data;
  }
}
