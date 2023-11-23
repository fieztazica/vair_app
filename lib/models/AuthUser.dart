import 'package:vair_app/models/User.dart';

class AuthUser {
  String? jwt;
  User? user;

  AuthUser({this.jwt, this.user});

  AuthUser.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jwt'] = jwt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
