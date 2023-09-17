import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/input/category_picker.dart';
import 'package:refilin_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/order_address_controller.dart';
import 'package:refilin_mobile/app/modules/home/controllers/carousel_controller_controller.dart';
import 'package:refilin_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:refilin_mobile/app/modules/profile/controllers/profile_controller.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_index_controller.dart';
import 'package:refilin_mobile/app/providers/address_provider.dart';
import 'package:refilin_mobile/app/providers/banner_provider.dart';
import 'package:refilin_mobile/app/providers/cart_provider.dart';
import 'package:refilin_mobile/app/providers/google_maps_provider.dart';
import 'package:refilin_mobile/app/providers/product_provider.dart';
import 'package:refilin_mobile/app/providers/region_provider.dart';
import 'package:refilin_mobile/app/providers/store_provider.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/location_service.dart';
import 'package:refilin_mobile/app/services/sql_lite_service.dart';

import '../controllers/core_controller.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<CoreController>(() => CoreController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    // Get.lazyPut<ProfileBinding>(() => ProfileBinding());
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<StoreProvider>(() => StoreProvider());
    Get.lazyPut<ProductProvider>(() => ProductProvider());
    Get.lazyPut<CartProvider>(() => CartProvider());
    Get.lazyPut<RegionProvider>(() => RegionProvider());
    Get.lazyPut<GoogleMapsProvider>(() => GoogleMapsProvider());
    Get.lazyPut<StoreIndexController>(() => StoreIndexController());
    Get.lazyPut<OrderAddressController>(() => OrderAddressController());
    Get.lazyPut<SqlLiteService>(() => SqlLiteService());
    Get.lazyPut<AddressProvider>(() => AddressProvider());
    Get.lazyPut<CategoryPickerController>(() => CategoryPickerController());
    Get.lazyPut<BannerProvider>(() => BannerProvider());
    Get.lazyPut<CarouselControllerController>(
        () => CarouselControllerController());
  }
}
