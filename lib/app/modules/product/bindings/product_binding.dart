import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/input/category_picker.dart';
import 'package:refilin_mobile/app/common/input/xpicker_image.dart';
import 'package:refilin_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/order_address_controller.dart';
import 'package:refilin_mobile/app/modules/product/controllers/product_create_controller.dart';
import 'package:refilin_mobile/app/modules/product/controllers/product_detail_controller.dart';
import 'package:refilin_mobile/app/modules/product/controllers/product_strore_controller.dart';
import 'package:refilin_mobile/app/modules/product/controllers/product_update_controller.dart';
import 'package:refilin_mobile/app/modules/review/controllers/review_controller.dart';
import 'package:refilin_mobile/app/providers/address_provider.dart';
import 'package:refilin_mobile/app/providers/cart_provider.dart';
import 'package:refilin_mobile/app/providers/product_provider.dart';
import 'package:refilin_mobile/app/providers/review_provider.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/imgae_picker_services.dart';

import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(),
    );
    Get.lazyPut<ProductUpdateController>(
      () => ProductUpdateController(),
    );
    Get.lazyPut<ProductStoreController>(
      () => ProductStoreController(),
    );
    Get.lazyPut<ProductCreateController>(
      () => ProductCreateController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<CartProvider>(() => CartProvider());
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<ProductProvider>(() => ProductProvider());
    Get.lazyPut<ImagePickerService>(() => ImagePickerService());
    Get.lazyPut<PickerController>(() => PickerController());
    Get.lazyPut<OrderAddressController>(() => OrderAddressController());
    Get.lazyPut<AddressProvider>(() => AddressProvider());
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
    Get.lazyPut<ProductProvider>(() => ProductProvider());
    Get.lazyPut<CartController>(() => CartController());
    // Get.lazyPut<LocalStorage>(() => LocalStorage());
    Get.put(CategoryPickerController(), permanent: true);
    Get.lazyPut<ReviewController>(() => ReviewController());
    Get.lazyPut<ReviewProvider>(() => ReviewProvider());
  }
}
