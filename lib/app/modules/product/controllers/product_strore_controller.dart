import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_filter_model.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/providers/product_provider.dart';

class ProductStoreController extends GetxController
    with StateMixin<List<ProductModel>> {
  //TODO: Implement ProductStroreController
  final productProvider = Get.find<ProductProvider>();
  Rx<ProductFilter> filter = ProductFilter(
    perPage: "1000",
    storeId: Get.arguments.toString(),
    search: "".obs,
    prices: [],
  ).obs;

  RxList<ProductModel> products = <ProductModel>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await getProducts();
  }

  Future<void> getProducts() async {
    try {
      final response = await productProvider.getProducts(
        filter: filter.value,
      );

      print("response products: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        if (response.body['data'].isEmpty) {
          change(products, status: RxStatus.empty());
          return;
        }
        products.assignAll(response.body['data']);
        change(products, status: RxStatus.success());
      } else {
        change(products, status: RxStatus.error(response.body['message']));
      }
    } catch (e) {
      print(e);
    }
  }

  //delete product
  Future<void> deleteProduct(int id) async {
    try {
      final response = await productProvider.deleteProduct(id);
      print("response delete product: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        products.removeWhere((element) => element.id == id);
        Future.delayed(const Duration(milliseconds: 100), () {
          Utils.snackMessage(
              title: "Berhasil",
              messages: "Produk Berhasil Dihapus",
              type: "success");
        });
        await getProducts();
        change(products, status: RxStatus.success());
      } else {
        change(products, status: RxStatus.error(response.body['message']));
      }
    } catch (e) {
      print(e);
    }
  }
}
