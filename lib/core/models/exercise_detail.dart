class ExerciseDetail {
  String? id;
  String? userId;
  String? exerciseId;
  int? score;

  ExerciseDetail({this.id, this.userId, this.exerciseId, this.score});

  ExerciseDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    exerciseId = json['exercise_id'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['exercise_id'] = this.exerciseId;
    data['score'] = this.score;
    return data;
  }
}
