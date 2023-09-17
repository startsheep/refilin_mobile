class ReviewModel {
  int? id;
  int? userId;
  int? productId;
  String? message;
  int? point;
  String? createdAt;
  String? updatedAt;
  User? user;

  ReviewModel(
      {this.id,
      this.userId,
      this.productId,
      this.message,
      this.point,
      this.createdAt,
      this.updatedAt,
      this.user});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    message = json['message'];
    point = json['point'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['message'] = message;
    data['point'] = point;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toCreateReview() {
    return {
      'message': message ?? 'Tidak ada komentar',
      'point': point,
      'product_id': productId,
    };
  }

  //copyWith
  ReviewModel copyWith({
    int? id,
    int? userId,
    int? productId,
    String? message,
    int? point,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      message: message ?? this.message,
      point: point ?? this.point,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }
}
//tocreate

class User {
  int? id;
  String? name;
  String? email;
  void emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role_id'] = roleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
