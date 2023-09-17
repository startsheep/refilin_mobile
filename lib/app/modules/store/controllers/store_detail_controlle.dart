import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/product_filter_model.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/models/store_model.dart';
import 'package:refilin_mobile/app/providers/product_provider.dart';
import 'package:refilin_mobile/app/providers/store_provider.dart';
import 'package:refilin_mobile/app/services/location_service.dart';

class StoreDetailController extends GetxController with StateMixin<StoreModel> {
  //TODO: Implement StoreDetailrController

  final storeProvider = Get.find<StoreProvider>();
  final productProvider = Get.find<ProductProvider>();
  final locationService = Get.find<LocationService>();
  RxList<ProductModel> products = <ProductModel>[].obs;
  Rx<StoreModel> store = StoreModel().obs;
  RxString search = "".obs;

  void getStore() async {
    try {
      final response = await storeProvider.getStore(
        storeId: store.value.id,
      );
      if (response.body['status'] == "SUCCESS") {
        print("store json${response.body['data']}");
        // stores.assignAll(response.body['data']);
        if (response.body['data'] is List) {
          store.value = response.body['data'][0];
          change(store.value, status: RxStatus.success());
        } else {
          store.value = response.body['data'];
          change(store.value, status: RxStatus.success());
        }
      }
    } catch (e) {
      print("error get store: $e");
    }
  }

  Future<List<ProductModel>> productsStore() async {
    try {
      final response = await productProvider.getProducts(
        filter: ProductFilter(
          storeId: store.value.id.toString(),
          perPage: "1000",
          search: "".obs,
          prices: [],
        ),
      );
      if (response.body['status'] == "SUCCESS") {
        // stores.assignAll(response.body['data']);
        products.assignAll(response.body['data']);
      }
    } catch (e) {
      print("error get store: $e");
    }
    return products;
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    store.value = Get.arguments!;
    getStore();
  }
}
