import 'package:get/get.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/create_address_controller.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/order_address_controller.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/payment_method_controller.dart';
import 'package:refilin_mobile/app/providers/address_provider.dart';
import 'package:refilin_mobile/app/providers/order_provider.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAddressController>(
      () => CreateAddressController(),
    );
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
    Get.lazyPut<AddressProvider>(() => AddressProvider());
    Get.lazyPut<OrderAddressController>(() => OrderAddressController());
    Get.lazyPut<PaymentMethodController>(() => PaymentMethodController());
    Get.lazyPut<OrderProvider>(() => OrderProvider());
  }
}
