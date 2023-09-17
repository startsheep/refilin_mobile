import 'package:image_picker/image_picker.dart';
import 'package:refilin_mobile/app/models/user.dart';

class StoreModel {
  int? id;
  int? userId;
  String? name;
  String? description;
  String? address;
  dynamic lat;
  dynamic long;
  String? logo;
  int? status;
  XFile? logoFile;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  StoreModel(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.address,
      this.lat,
      this.long,
      this.logoFile,
      this.logo,
      this.status,
      this.createdAt,
      this.user,
      this.updatedAt});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    logo = json['logo'];
    status = json['status'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['description'] = description;
    data['address'] = address;
    data['lat'] = lat;
    data['long'] = long;
    data['logo'] = logo;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // toSaveJson()
  Map<String, dynamic> toSaveJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['address'] = address;
    data['lat'] = lat ?? '-';
    data['long'] = long ?? '-';
    return data;
  }
}
