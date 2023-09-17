import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_filter_model.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:refilin_mobile/app/providers/cart_provider.dart';
import 'package:refilin_mobile/app/providers/product_provider.dart';

class HomeController extends GetxController with StateMixin {
  //TODO: Implement HomeController
  RxList<ProductModel> vegetables = <ProductModel>[].obs;
  RxList<ProductModel> fruits = <ProductModel>[].obs;
  final productProvider = Get.find<ProductProvider>();
  final cartProvider = Get.find<CartProvider>();
  // Rx<ProductFilter> filter = ProductFilter(
  //   perPage: "5",
  //   category: "Sayur",
  //   // storeId: null,
  // ).obs;
  Future<void> getVegetables() async {
    try {
      final response = await productProvider.getProducts(
        filter: ProductFilter(
            perPage: "5",
            category: "Sayur",
            search: "".obs,
            prices: [] // storeId: null,
            ),
      );

      print("response products: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        if (response.body['data'].isEmpty) {
          change(vegetables, status: RxStatus.empty());
          return;
        }
        vegetables.assignAll(response.body['data']);
        change(vegetables, status: RxStatus.success());
      } else {
        change(vegetables, status: RxStatus.error(response.body['message']));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFruits() async {
    try {
      final response = await productProvider.getProducts(
        filter: ProductFilter(
            perPage: "5",
            category: "Buah",
            search: "".obs,
            prices: [] // storeId: null,
            // storeId: null,
            ),
      );
      print("response fruits: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        if (response.body['data'].isEmpty) {
          change(fruits, status: RxStatus.empty());
          return;
        }
        fruits.assignAll(response.body['data']);
        change(fruits, status: RxStatus.success());
      } else {
        change(fruits, status: RxStatus.error(response.body['message']));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addToCart({required ProductModel product}) async {
    try {
      print("product id: ${product.id}");
      final response = await cartProvider.addToCart(
        productId: product.id.toString(),
        qty: "1",
      );
      print("response add to cart: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        Utils.snackMessage(
          title: "berhasil",
          messages: "${product.name} berhasil ditambahkan ke keranjang",
          type: "success",
        );
        Get.find<CartController>().getCarts();
      } else {
        Utils.snackMessage(
          title: "gagal",
          messages: "${product.name} gagal ditambahkan ke keranjang",
          type: "error",
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getVegetables();
    getFruits();
  }
}
