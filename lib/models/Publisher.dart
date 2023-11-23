class Publisher {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  Publisher(
      {this.id,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  Publisher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    return data;
  }
}
