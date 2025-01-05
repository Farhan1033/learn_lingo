class ExerciseGamificationApi {
  String? message;
  int? statusCode;
  Data? data;

  ExerciseGamificationApi({this.message, this.statusCode, this.data});

  ExerciseGamificationApi.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  int? totalPoints;
  int? totalExp;
  int? helpCount;
  int? healthCount;

  Data(
      {this.id,
      this.userId,
      this.totalPoints,
      this.totalExp,
      this.helpCount,
      this.healthCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPoints = json['total_points'];
    totalExp = json['total_exp'];
    helpCount = json['help_count'];
    healthCount = json['health_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['total_points'] = this.totalPoints;
    data['total_exp'] = this.totalExp;
    data['help_count'] = this.helpCount;
    data['health_count'] = this.healthCount;
    return data;
  }
}
