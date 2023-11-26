import 'package:vair_app/models/AuthUser.dart';

class AppConverter {
  static AuthUser? convertAuthUser(dynamic input) {
    try {
      Map<String, dynamic> json = Map.from(input);
      AuthUser data = AuthUser.fromJson(json);
      return data;
    } catch (e) {
      return null;
    }
  }
}
