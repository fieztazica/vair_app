class Category {
  int? id;
  String? name;
  String? description;
  String? normalizedName;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  Category(
      {this.id,
      this.name,
      this.description,
      this.normalizedName,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    normalizedName = json['normalized_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['normalized_name'] = this.normalizedName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}
