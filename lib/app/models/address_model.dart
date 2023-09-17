import 'package:get/get.dart';

class AddressModel {
  int? id;
  int? userId;
  String? contactName;
  String? contactPhone;
  int? provinceId;
  int? regencyId;
  int? districtId;
  int? villageId;
  String? address;
  RxInt? isDefault;
  String? createdAt;
  String? updatedAt;
  Province? province;
  Regency? regency;
  District? district;
  Village? village;

  AddressModel(
      {this.id,
      this.userId,
      this.contactName,
      this.contactPhone,
      this.provinceId,
      this.regencyId,
      this.districtId,
      this.villageId,
      this.address,
      this.isDefault,
      this.createdAt,
      this.updatedAt,
      this.province,
      this.regency,
      this.district,
      this.village});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    provinceId = json['province_id'];
    regencyId = json['regency_id'];
    districtId = json['district_id'];
    villageId = json['village_id'];
    address = json['address'];
    isDefault = RxInt(json['is_default']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    province =
        json['province'] != null ? Province.fromJson(json['province']) : null;
    regency =
        json['regency'] != null ? Regency.fromJson(json['regency']) : null;
    district =
        json['district'] != null ? District.fromJson(json['district']) : null;
    village =
        json['village'] != null ? Village.fromJson(json['village']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['contact_name'] = contactName;
    data['contact_phone'] = contactPhone;
    data['province_id'] = provinceId;
    data['regency_id'] = regencyId;
    data['district_id'] = districtId;
    data['village_id'] = villageId;
    data['address'] = address;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (province != null) {
      data['province'] = province!.toJson();
    }
    if (regency != null) {
      data['regency'] = regency!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (village != null) {
      data['village'] = village!.toJson();
    }
    return data;
  }

  // toForm
  Map<String, dynamic> toForm() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact_name'] = contactName;
    data['contact_phone'] = contactPhone;
    data['province_id'] = province!.id!;
    data['regency_id'] = regency!.id!;
    data['district_id'] = district!.id!;
    data['village_id'] = village!.id!;
    data['address'] = address;
    data['is_default'] = isDefault!.value;
    return data;
  }

  String get region {
    return '${village!.name}, ${district!.name}, ${regency!.name}, ${province!.name}';
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = name;
    return data;
  }
}

class Regency extends Province {
  String? idProvinsi;

  Regency({int? id, String? name, this.idProvinsi}) : super(id: id, name: name);

  Regency.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    idProvinsi = json['id_provinsi'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['id_provinsi'] = idProvinsi;
    return data;
  }
}

class District extends Province {
  String? idKota;

  District({int? id, String? name, this.idKota}) : super(id: id, name: name);

  District.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    idKota = json['id_kota'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['id_kota'] = idKota;
    return data;
  }
}

class Village extends Province {
  String? idKecamatan;

  Village({int? id, String? name, this.idKecamatan})
      : super(id: id, name: name);

  Village.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    idKecamatan = json['id_kecamatan'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['id_kecamatan'] = idKecamatan;
    return data;
  }
}
