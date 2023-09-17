import 'package:json_annotation/json_annotation.dart';
import 'package:refilin_mobile/app/models/role_model.dart';

@JsonSerializable()
class UserModel {
  int? uid;
  int? roleId;
  String? email;
  String? name;
  String? avatar;
  String? phone;
  String? password;
  RoleModel? role;
  String? token;
  String? retypedPassword;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.avatar,
    this.phone,
    this.roleId,
    this.password,
    this.role,
    this.token,
    this.retypedPassword,
  });

  ///to json
  Map<String, dynamic> toJson() => {
        "id": uid,
        "email": email,
        "name": name,
        "avatar": avatar,
        "phone": phone,
        "password": password,
        "role": role,
        'role_id': roleId,
        "token": token,
        "retype_Password": retypedPassword,
      };
  // factory UserModel.fromJson(Map<String, dynamic> json) =>
  //     _$UserModelFromJson(json);
  //toJson is the instance method
  // Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
      token: json['token'],
      role: json['role'] != null ? RoleModel.fromJson(json['role']) : null,
      roleId: json['role_id'],
      password: json['password'],
      retypedPassword: json['retypedPassword'],
    );
  }

  UserModel copyWith({
    int? uid,
    String? email,
    String? name,
    String? avatar,
    RoleModel? role,
    String? token,
    int? roleId,
    String? phone,
    String? password,
    String? retypedPassword,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      roleId: roleId ?? this.roleId,
      password: password ?? this.password,
      retypedPassword: retypedPassword ?? this.retypedPassword,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }
}
