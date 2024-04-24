class UserModel {
  var id;
  var email;
  UserModel({this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email']);
  }
}
