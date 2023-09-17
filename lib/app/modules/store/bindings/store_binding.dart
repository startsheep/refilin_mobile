import 'package:get/get.dart';

import 'package:refilin_mobile/app/common/input/xpicker_image.dart';
import 'package:refilin_mobile/app/modules/store/controllers/manage_order_controller.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_create_controller.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_detail_controlle.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_index_controller.dart';
import 'package:refilin_mobile/app/providers/store_provider.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/imgae_picker_services.dart';
import 'package:refilin_mobile/app/services/location_service.dart';

import '../controllers/store_controller.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageOrderController>(
      () => ManageOrderController(),
    );
    Get.lazyPut<StoreDetailController>(
      () => StoreDetailController(),
    );
    Get.lazyPut<StoreIndexController>(
      () => StoreIndexController(),
    );
    Get.lazyPut<StoreController>(
      () => StoreController(),
    );
    Get.lazyPut<StoreProvider>(() => StoreProvider());
    Get.lazyPut<StoreProvider>(() => StoreProvider());
    Get.lazyPut<StoreCreateController>(() => StoreCreateController());
    Get.lazyPut<PickerController>(() => PickerController());
    Get.lazyPut<ImagePickerService>(() => ImagePickerService());
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<ApiService>(() => ApiService());
  }
}
