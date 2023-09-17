import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/models/order_modell.dart';
import 'package:refilin_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/order_address_controller.dart';
import 'package:refilin_mobile/app/modules/payment/views/payment_code_view.dart';
import 'package:refilin_mobile/app/providers/order_provider.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutControlle
  final OrderAddressController orderAddressController =
      Get.find<OrderAddressController>();
  Rx<AddressModel?> currentAddress = Rx<AddressModel?>(null);
  Rx<OrderModel> order = OrderModel().obs;
  final orderProvider = Get.find<OrderProvider>();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    orderAddressController.getAddress();
    currentAddress.value = orderAddressController.selectedAddress.value;
    ever(orderAddressController.selectedAddress, (callback) {
      currentAddress.value = callback as AddressModel?;
    });
    order.value = Get.arguments;
  }

  Future<void> createOrder() async {
    print(order.value.forCreate());
    try {
      isLoading.value = true;
      final response = await orderProvider.createOrder(order: order.value);
      print("response create order: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        // Get.offAllNamed('/order');
        Get.find<CartController>().clearCart();
        Get.to(
          () => const PaymentCodeView(),
          arguments: [
            response.body['data']['order_id'],
            response.body['data']['total'],
          ],
        );
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
