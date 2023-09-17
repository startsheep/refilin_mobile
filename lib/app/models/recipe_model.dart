class RecipeModel {
  int? id;
  String? name;
  String? description;
  String? ingredient;
  String? steps;
  String? createdAt;
  String? updatedAt;

  RecipeModel(
      {this.id,
      this.name,
      this.description,
      this.ingredient,
      this.steps,
      this.createdAt,
      this.updatedAt});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    ingredient = json['ingredient'];
    steps = json['steps'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['ingredient'] = ingredient;
    data['steps'] = steps;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
