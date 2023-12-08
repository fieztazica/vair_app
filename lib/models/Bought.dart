import 'package:vair_app/models/Feedback.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/models/User.dart';

class Bought {
  int? id;
  int? total;
  String? comment;
  bool? recommend;
  String? boughtDate;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  User? usersPermissionsUser;
  Feedback? feedback;
  Product? product;

  Bought(
      {this.id,
      this.total,
      this.comment,
      this.recommend,
      this.boughtDate,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.usersPermissionsUser,
      this.feedback,
      this.product});

  Bought.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    comment = json['comment'];
    recommend = json['recommend'];
    boughtDate = json['bought_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    usersPermissionsUser = json['users_permissions_user'] != null
        ? User.fromJson(json['users_permissions_user'])
        : null;
    feedback = json['feedback'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['comment'] = comment;
    data['recommend'] = recommend;
    data['bought_date'] = boughtDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    if (usersPermissionsUser != null) {
      data['users_permissions_user'] = usersPermissionsUser!.toJson();
    }
    data['feedback'] = feedback;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
