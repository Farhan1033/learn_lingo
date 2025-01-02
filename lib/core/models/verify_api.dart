class VerifyApi {
  String? email;
  String? codeVerify;

  VerifyApi({this.email, this.codeVerify});

  VerifyApi.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    codeVerify = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['code'] = codeVerify;
    return data;
  }
}
