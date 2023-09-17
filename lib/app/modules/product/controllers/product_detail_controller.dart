import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/providers/cart_provider.dart';
import 'package:refilin_mobile/app/providers/product_provider.dart';

class ProductDetailController extends GetxController
    with StateMixin<Rx<ProductModel>> {
  //TODO: Implement ProductDetailController
  final productProvider = Get.find<ProductProvider>();
  final CartProvider cartProvider = Get.find<CartProvider>();
  Rx<ProductModel> product = ProductModel().obs;

  @override
  void onInit() {
    super.onInit();
    product.value = Get.arguments;
    getProduct();
  }

  Future<void> getProduct() async {
    try {
      final response =
          await productProvider.getProduct(product.value.id.toString());
      print("response product: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        product.value = response.body['data'];
        change(product, status: RxStatus.success());
      } else {
        Get.snackbar(
          "Gagal",
          response.body['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.errorColor,
          colorText: Get.theme.colorScheme.onSecondary,
        );
      }
    } catch (e) {
      print(e);
    }
  }
  //

  void addToCart() async {
    cartProvider
        .addToCart(
      productId: product.value.id.toString(),
      qty: 1,
    )
        .then((res) {
      if (res.body['status'] == 'SUCCESS') {
        Utils.snackMessage(
          title: "Berhasil",
          messages: "${product.value.name} berhasil ditambahkan ke keranjang}",
          type: "success",
        );
      } else {
        Get.snackbar(
          "Gagal",
          res.body['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.errorColor,
          colorText: Get.theme.colorScheme.onSecondary,
        );
      }
    });
  }
}
