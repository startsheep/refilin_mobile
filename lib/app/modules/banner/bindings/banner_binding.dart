import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/input/xpicker_image.dart';
import 'package:refilin_mobile/app/modules/banner/controllers/create_promo_controller.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/payment_method_controller.dart';
import 'package:refilin_mobile/app/providers/banner_provider.dart';

import '../controllers/banner_controller.dart';

class BannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePromoController>(
      () => CreatePromoController(),
    );
    Get.lazyPut<BannerController>(
      () => BannerController(),
    );
    Get.lazyPut<CreatePromoController>(() => CreatePromoController());
    Get.lazyPut<PickerController>(() => PickerController());
    Get.lazyPut<BannerProvider>(() => BannerProvider());
    Get.lazyPut<PaymentMethodController>(() => PaymentMethodController());
  }
}
