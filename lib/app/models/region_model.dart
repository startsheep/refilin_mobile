import 'package:get/get.dart';

class Province {
  final int? id;
  final String? name;

  Province({
    this.id,
    this.name,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['nama'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  String toString() {
    return 'Province{ id: $id, name: $name}';
  }
}

class Regency extends Province {
  final dynamic provinceId;
  Regency({
    this.provinceId,
    id,
    name,
    regionId,
  }) : super(
          id: id,
          name: name,
        );

  factory Regency.fromJson(Map<String, dynamic> json) {
    return Regency(
      provinceId: json['id_provinsi'],
      id: json['id'],
      name: json['nama'],
    );
  }
  //to json
  @override
  Map<String, dynamic> toJson() => {
        'province_id': provinceId,
        'id': id,
        'name': name,
      };

  @override
  String toString() {
    return 'Regency{provinceId: $provinceId,, id: $id, name: $name, ';
  }
}

class District extends Regency {
  final dynamic regencyId;

  District({
    this.regencyId,
    id,
    name,
  }) : super(
          id: id,
          name: name,
        );

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      regencyId: json['id_kota'],
      id: json['id'],
      name: json['nama'],
    );
  }
  //to json
  @override
  Map<String, dynamic> toJson() => {
        'regency_id': regencyId,
        'id': id,
        'name': name,
        'province_id': provinceId,
      };

  @override
  String toString() {
    return 'District{regencyId: $regencyId, id: $id, name: $name,  provinceId: $provinceId,}';
  }
}

class Village extends District {
  dynamic districtId;

  Village({
    this.districtId,
    id,
    name,
  }) : super(
          id: id,
          name: name,
        );

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      districtId: json['id_kecamatan'],
      id: json['id'],
      name: json['nama'],
    );
  }
  //to json
  @override
  Map<String, dynamic> toJson() => {
        'district_id': districtId,
        'id': id,
        'name': name,
        'province_id': provinceId,
        'regency_id': regencyId,
      };

  @override
  String toString() {
    return 'Village{districtId: $districtId, id: $id, name: $name,  provinceId: $provinceId, regencyId: $regencyId, }';
  }
}

class OrderAddressModel {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? province;
  String? regency;
  String? district;
  String? village;
  String? postalCode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  RxInt? isDefault;

  OrderAddressModel(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.province,
      this.regency,
      this.district,
      this.village,
      this.postalCode,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isDefault});

  factory OrderAddressModel.fromJson(Map<String, dynamic> json) {
    return OrderAddressModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      province: json['province'],
      regency: json['regency'],
      district: json['district'],
      village: json['village'],
      postalCode: json['postal_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      isDefault: RxInt(json['is_default']),
    );
  }
  //to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'province': province,
        'regency': regency,
        'district': district,
        'village': village,
        'postal_code': postalCode,
        'is_default': isDefault!.value,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
      };

  //make copy
  OrderAddressModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    String? province,
    String? regency,
    String? district,
    String? village,
    String? postalCode,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    RxInt? isDefault,
  }) {
    return OrderAddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      province: province ?? this.province,
      regency: regency ?? this.regency,
      district: district ?? this.district,
      village: village ?? this.village,
      postalCode: postalCode ?? this.postalCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  String get region => '$village, $district, $regency, $province';
  @override
  String toString() {
    return 'OrderAddressModel{id: $id, name: $name, phone: $phone, address: $address, province: $province, regency: $regency, district: $district, village: $village, postalCode: $postalCode, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isDefault: $isDefault}';
  }
}
