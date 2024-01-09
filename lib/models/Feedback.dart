import 'package:vair_app/models/Bought.dart';
import 'package:vair_app/models/User.dart';

class Feedback {
  int? id;
  String? comment;
  bool? recommend;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  User? usersPermissionsUser;
  Bought? bought;

  Feedback(
      {this.id,
      this.comment,
      this.recommend,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.usersPermissionsUser,
      this.bought});

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    recommend = json['recommend'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    usersPermissionsUser = json['users_permissions_user'] != null
        ? User.fromJson(json['users_permissions_user'])
        : null;
    bought = json['bought'] != null ? Bought.fromJson(json['bought']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['recommend'] = recommend;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    if (usersPermissionsUser != null) {
      data['users_permissions_user'] = usersPermissionsUser!.toJson();
    }
    if (bought != null) {
      data['bought'] = bought!.toJson();
    }
    return data;
  }
}

class FeedbackDto {
  String? comment;
  bool? recommend;
  String? productId;
}
