class RoleModel {
  int? id;
  String? name;

  RoleModel({
    this.id,
    this.name,
  });

  ///to json
  ///toJson is the instance method
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
