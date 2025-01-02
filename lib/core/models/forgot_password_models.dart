class ForgotPasswordModels {
  String? email;
  String? codeVerify;
  String? newPassword;

  ForgotPasswordModels({this.email, this.codeVerify, this.newPassword});

  ForgotPasswordModels.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    codeVerify = json['code'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['code'] = codeVerify;
    data['new_password'] = newPassword;
    return data;
  }
}
