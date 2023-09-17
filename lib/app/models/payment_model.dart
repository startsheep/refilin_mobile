import 'package:get/get.dart';

class PaymentModel {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? logo;
  RxBool? isActive;
  RxBool? isSelected;
  String? code;
  String? createdAt;
  String? updatedAt;

  List<PaymentModel>? children = [];

  PaymentModel({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.code,
    this.logo,
    this.isActive,
    this.isSelected,
    this.children,
    this.createdAt,
    this.updatedAt,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    isActive = json['isActive'];
    isSelected = json['isSelected'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['children'] != null) {
      children = <PaymentModel>[];
      json['children'].forEach((v) {
        children!.add(PaymentModel.fromJson(v));
      });
    }
  }
}

//list payment
List<PaymentModel> resourcesPayment() {
  return [
    PaymentModel(
        id: '1',
        name: 'COD',
        description: 'Cash on Delivery',
        logo: 'cash.png',
        isActive: RxBool(true),
        isSelected: RxBool(false),
        code: 'COD',
        children: []),
    PaymentModel(
      id: '2',
      name: 'Bank Transfer',
      description: 'Pay via bank transfer',
      logo: 'transfer.png',
      isActive: RxBool(true),
      isSelected: RxBool(false),
      code: 'BT',
      children: [
        PaymentModel(
            id: '21',
            name: 'Bank BCA',
            description: 'Bank BCA Transfer',
            logo: 'bca.png',
            isActive: RxBool(true),
            isSelected: RxBool(false),
            code: 'BCA',
            children: []),
        PaymentModel(
            id: '22',
            name: 'Bank BNI',
            description: 'Bank BNI Transfer',
            logo: 'bni.png',
            isActive: RxBool(true),
            isSelected: RxBool(false),
            code: 'BNI',
            children: []),
        PaymentModel(
            id: '23',
            name: 'Bank BRI',
            description: 'Bank BRI Transfer',
            logo: 'bri.png',
            isActive: RxBool(true),
            isSelected: RxBool(false),
            code: 'BRI',
            children: []),
        // Add more child banks here...
      ],
    ),
    // Add more payment methods here...
  ];
}
