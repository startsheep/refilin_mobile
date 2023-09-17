import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/store_model.dart';
import 'package:refilin_mobile/app/providers/store_provider.dart';
import 'package:refilin_mobile/app/services/location_service.dart';

class StoreIndexController extends GetxController with StateMixin {
  //TODO: Implement StoreIndexController
  final storeProvider = Get.find<StoreProvider>();
  RxList<StoreModel> stores = <StoreModel>[].obs;
  final locationService = Get.find<LocationService>();
  RxString search = "".obs;
  @override
  void onInit() {
    super.onInit();
    getStores();
    ever(search, (callback) {
      getStores();
    });
  }

  Future<void> getStores() async {
    try {
      final response = await storeProvider.getStores(
        search: search.value,
      );
      if (response.body['status'] == "SUCCESS") {
        if (response.body['data'].isEmpty) {
          change(stores, status: RxStatus.empty());
          return;
        }
        print("store json${response.body['data']}");
        stores.assignAll(response.body['data']);
        change(stores, status: RxStatus.success());
      }
    } catch (e) {
      print("error get store: $e");
    }
  }

  Future<double> getDistance({
    required double endLatitude,
    required double endLongitude,
  }) async {
    await locationService.getCurrentPosition();
    return locationService.calculateDistance(
      locationService.latitude.value,
      locationService.longitude.value,
      endLatitude,
      endLongitude,
    );
  }
}
