import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_filter_model.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:refilin_mobile/app/providers/cart_provider.dart';
import 'package:refilin_mobile/app/providers/product_provider.dart';

class ProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  //TODO: Implement ProductController
  final productProvider = Get.find<ProductProvider>();
  final cartProvider = Get.find<CartProvider>();
  final cartController = Get.find<CartController>();
  final RxList<ProductModel> products = <ProductModel>[].obs;
  Rx<ProductFilter> filter = ProductFilter(
    perPage: "1000",
    category: "",
    search: "".obs,
    // storeId: null,
    prices: [0, 0],
    store: true,
  ).obs;
  void getProducts() async {
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
      }
    } catch (e) {
      change(products, status: RxStatus.error(e.toString()));
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProducts();

    debounce(filter.value.search!, (callback) {
      getProducts();
    }, time: const Duration(milliseconds: 500));
  }

  void addToCart(ProductModel product) async {
    await cartProvider
        .addToCart(
      productId: product.id.toString(),
      qty: "1",
    )
        .then((res) {
      if (res.body['status'] == 'SUCCESS') {
        Utils.snackMessage(
            title: "Berhsail",
            messages: "${product.name} berhasil ditambahkan ke keranjang}",
            type: "success");
        cartController.getCarts();
      } else {
        Get.snackbar(
          'Error',
          res.body['message'],
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  //clear filter
  void clearFilter() {
    filter.value = ProductFilter(
      perPage: "1000",
      category: "",
      prices: [0, 0],

      search: "".obs,
      // storeId: null,
      store: true,
    );
    getProducts();
  }
}
