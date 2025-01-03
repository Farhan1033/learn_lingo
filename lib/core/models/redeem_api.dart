class RedeemApi {
  String? message;
  int? statusCode;
  Data? data;

  RedeemApi({this.message, this.statusCode, this.data});

  RedeemApi.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? message;

  Data({this.name, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['message'] = this.message;
    return data;
  }
}
