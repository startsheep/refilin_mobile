import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/cart_item_model.dart';
import 'package:refilin_mobile/app/models/store_model.dart';

class CartModel {
  StoreModel? store;
  RxBool? selected;
  int? totalPrice;
  List<CartItemModel> cartItems = <CartItemModel>[];
  CartModel({
    this.store,
    this.cartItems = const <CartItemModel>[],
    this.selected,
    this.totalPrice,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    store = StoreModel.fromJson(json['store']);
    cartItems = json['cart_items'] != null
        ? (json['cart_items'] as List)
            .map((e) => CartItemModel.fromJson(e).copyWith(
                  selected: false.obs,
                ))
            .toList()
        : <CartItemModel>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store'] = store!.toJson();
    data['cart_items'] = cartItems.map((e) => e.toJson()).toList();

    return data;
  }

  CartModel copyWith({
    StoreModel? store,
    RxBool? selected,
    List<CartItemModel>? cartItems,
  }) {
    return CartModel(
      store: store ?? this.store,
      selected: selected ?? this.selected,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  String get total {
    return Utils.formatCurrency(
        double.parse(cartItems.fold<int>(0, (sum, item) {
      return sum + (int.parse(item.product!.price!) * int.parse(item.qty!));
    }).toString()));
  }
}
