class SearchLessonApi {
  String? message;
  int? statusCode;
  List<Data>? data;

  SearchLessonApi({this.message, this.statusCode, this.data});

  SearchLessonApi.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? courseId;
  String? name;
  String? description;
  String? videoID;
  String? exerciseID;
  String? summaryID;

  Data(
      {this.id,
      this.courseId,
      this.name,
      this.description,
      this.videoID,
      this.exerciseID,
      this.summaryID});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    name = json['name'];
    description = json['description'];
    videoID = json['VideoID'];
    exerciseID = json['ExerciseID'];
    summaryID = json['SummaryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['VideoID'] = this.videoID;
    data['ExerciseID'] = this.exerciseID;
    data['SummaryID'] = this.summaryID;
    return data;
  }
}
