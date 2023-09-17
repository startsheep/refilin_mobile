import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/cart_item_model.dart';
import 'package:refilin_mobile/app/models/cart_model.dart';
import 'package:refilin_mobile/app/models/order_modell.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/order_address_controller.dart';
import 'package:refilin_mobile/app/providers/cart_provider.dart';

class CartController extends GetxController with StateMixin<List<CartModel>> {
  final cartProvider = Get.find<CartProvider>();
  RxBool selectAll = false.obs;
  RxList<CartModel> carts = <CartModel>[].obs;
  RxList<CartModel> selectedCarts = <CartModel>[].obs;
  OrderModel order = OrderModel();
  final OrderAddressController orderAddressController =
      Get.find<OrderAddressController>();
  RxInt total = 0.obs;

  Future<void> getCarts() async {
    try {
      final response = await cartProvider.getCart();
      print("response carts: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        if (response.body['data'].isEmpty) {
          change(carts, status: RxStatus.empty());
          return;
        }
        change(carts, status: RxStatus.success());
        carts.assignAll(response.body['data']);
      }
    } catch (e) {
      change(carts, status: RxStatus.error(e.toString()));
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCarts();

    everAll([carts, selectedCarts], (_) {
      // for (var cart in selectedCarts) {
      //   for (var item in cart.cartItems) {
      //     ever(item.selected!, (callback) {
      //       calculateTotal();
      //     });
      //   }
      // }
      // Update selectAll whenever selectedCarts changes
      if (selectedCarts.length == carts.length) {
        selectAll.value = true;
      } else {
        selectAll.value = false;
      }
    });
    orderAddressController.getAddress();
  }

  void calculateTotal() {
    total.value = carts.fold<int>(0, (sum, cart) {
      return sum +
          cart.cartItems.fold<int>(0, (sum, item) {
            if (item.selected!.value) {
              return sum +
                  (int.parse(item.qty) * int.parse(item.product!.price!));
            } else {
              return sum;
            }
          });
    });
  }

  void toggleStoreSelection(CartModel store) {
    store.selected!.value = !store.selected!.value;
    updateSelectedCarts(store);
    calculateTotal();
  }

  void toggleItemSelection(CartItemModel item, CartModel cart) {
    // When item checked, check store if all items checked
    item.selected!.value = !item.selected!.value;

    // Update the selectAll flag of the store
    cart.selected!.value = cart.cartItems.every((item) => item.selected!.value);

    // If the item is selected, add the store to selectedCarts
    if (item.selected!.value) {
      selectedCarts.add(cart);
    } else {
      // If the item is unselected, check if any other item in the store is still selected
      // If not, remove the store from selectedCarts
      if (!cart.cartItems.any((item) => item.selected!.value)) {
        selectedCarts.remove(cart);
      }
    }

    calculateTotal();
  }

  void updateSelectedCarts(CartModel store) {
    // If store is selected, add to selectedCarts
    if (store.selected!.value) {
      selectedCarts.add(store);

      // // If all items in store is selected, add to selectedCarts
      // if (store.cartItems.every((item) => item.selected!.value)) {
      //   selectedCarts.add(store);
      //   //select all items in store
      // }
      for (var item in store.cartItems) {
        item.selected!.value = true;
      }
    } else {
      // If store is unselected, remove from selectedCarts
      selectedCarts.remove(store);

      /// Unselect all items in store
      for (var item in store.cartItems) {
        item.selected!.value = false;
      }
    }
  }

  void selectAllCarts() {
    selectAll.value = !selectAll.value;
    for (var cart in carts) {
      cart.selected!.value = selectAll.value;
      for (var item in cart.cartItems) {
        item.selected!.value = selectAll.value;
      }
    }
    // After updating all selected values, refresh the selectedCarts list
    if (selectAll.value) {
      // If selectAll is true, assign all carts to selectedCarts
      selectedCarts.assignAll(carts);
    } else {
      // If selectAll is false, clear selectedCarts
      selectedCarts.clear();
    }
    calculateTotal();
  }

  void increaseQty(CartItemModel item) async {
    await cartProvider.addQty(id: item.id.toString()).then((res) {
      if (res.body['status'] == 'SUCCESS') {
        // Update the quantity locally after successful API call
        final updatedQty = int.parse(item.qty) + 1;
        item.qty = updatedQty.toString();
        calculateTotal();
      }
    });
  }

  void decreaseQty(CartItemModel item) async {
    await cartProvider.reduceQty(id: item.id.toString()).then((res) {
      if (res.body['status'] == 'SUCCESS') {
        // Update the quantity locally after successful API call
        final updatedQty = int.parse(item.qty) - 1;
        item.qty = updatedQty.toString();
        calculateTotal();
      }
    });
  }

  void removeItem(CartItemModel item, CartModel cart) async {
    await cartProvider.deleteCart(id: item.id!.toString()).then((res) {
      if (res.body['status'] == 'SUCCESS') {
        // Update the quantity locally after successful API call
        cart.cartItems.remove(item);
        getCarts();
        calculateTotal();
      }
    });
  }

  void mappingOrder() {
    final cartItems = <CartModel>[];
    //select only items in selectedCarts is selected
    for (var cart in selectedCarts) {
      final selectedItems = <CartItemModel>[];
      for (var item in cart.cartItems) {
        if (item.selected!.value) {
          selectedItems.add(item);
        }
      }
      cart.cartItems = selectedItems;
      cartItems.add(cart);
    }

    order = OrderModel(
      totalPrice: total.value,
      carts: cartItems,
    );
  }

  void clearCart() {
    carts.clear();
    selectedCarts.clear();
    total.value = 0;
  }
}
