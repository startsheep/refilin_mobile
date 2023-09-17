import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/models/store_model.dart';

class UserOrderModel {
  StoreModel? store;
  List<OrderItems>? orderItems;

  UserOrderModel({this.store, this.orderItems});

  UserOrderModel.fromJson(Map<String, dynamic> json) {
    store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  //
  int get totalPrice {
    int total = 0;
    for (var element in orderItems!) {
      total += int.parse(element.qty!) * int.parse(element.product!.price!);
    }
    return total;
  }

  String get totalPriceFormatted =>
      Utils.formatCurrency(totalPrice.toDouble(), locale: "id");
  String get totalQty {
    int total = 0;
    for (var element in orderItems!) {
      total += int.parse(element.qty!);
    }
    return total.toString();
  }
}

class OrderItems {
  int? id;
  int? orderId;
  int? productId;
  String? qty;
  int? status;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  OrderItems(
      {this.id,
      this.orderId,
      this.productId,
      this.qty,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.product});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    qty = json['qty'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }

  // String get total {
  // }
}
