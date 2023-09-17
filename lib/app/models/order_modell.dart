import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/cart_model.dart';

class OrderModel {
  List<CartModel>? carts = <CartModel>[];

  String? id;
  OrderStatus? status;
  String? orderDate;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? orderCode;
  int? totalPrice;
  OrderModel({
    this.carts,
    this.totalPrice,
    this.id,
    this.status,
    this.orderDate,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.orderCode,
  });

  OrderModel.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carts'] = carts!.map((e) => e.toJson()).toList();
    data['total_price'] = totalPrice;
    return data;
  }

  Map<String, dynamic> forCreate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //
    data['bank_code'] = paymentMethod;
    data['cart_ids'] = carts!
        .map((cart) => cart.cartItems.map((item) => item.id))
        .toList()
        .expand((ids) => ids) // Use expand to flatten the list
        .toList();

    return data;
  }

  String get total {
    return Utils.formatCurrency(totalPrice!.toDouble(), locale: "id");
  }
}

enum OrderStatus { pending, packing, shipping, completed, cancelled, all }
