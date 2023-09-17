import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:refilin_mobile/app/models/product_model.dart';

class CartItemModel {
  int? id;
  int? userId;
  dynamic productId;
  dynamic qty;
  ProductModel? product;
  String? createdAt;
  RxBool? selected;
  String? updatedAt;

  CartItemModel({
    this.id,
    this.userId,
    this.productId,
    this.qty,
    this.product,
    this.createdAt,
    this.selected,
    this.updatedAt,
  });

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // userId = json['user_id'];
    productId = json['product_id'];
    qty = json['qty'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['product'] = product?.toJson();
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  //make copy of this object
  CartItemModel copyWith({
    int? id,
    int? userId,
    int? productId,
    dynamic qty,
    ProductModel? product,
    RxBool? selected,
    String? createdAt,
    String? updatedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      product: product ?? this.product,
      selected: selected ?? this.selected,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
