import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/category_model.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/product/controllers/product_strore_controller.dart';
import 'package:refilin_mobile/app/providers/product_provider.dart';

class ProductUpdateController extends GetxController with StateMixin {
  //TODO: Implement ProductCreateController
  Rx<ProductModel> product = ProductModel().obs;
  Rx<XFile> image = XFile('').obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  Rx<CategoryModel> category = CategoryModel().obs;
  final productProvider = Get.find<ProductProvider>();
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  Future<void> updateProduct() async {
    change(product, status: RxStatus.loading());
    await productProvider
        .updateProduct(
      product: product.value,
      image: image.value.path != '' ? File(image.value.path) : null,
    )
        .then((res) {
      print(res.body);
      if (res.body['status'] == 'SUCCESS') {
        Get.back();
        Utils.snackMessage(
            title: "Berhasil",
            messages: "Berhasil Memperbarui ${product.value.name}}",
            type: "success");
        Get.find<ProductStoreController>().getProducts();
      } else {
        Utils.snackMessage(
          title: "Terjadi Kesalahan",
          messages: "Periksa kembali data yang anda masukkan",
          type: "error",
        );
      }
      change(product, status: RxStatus.success());
    }).catchError((e) {
      change(product, status: RxStatus.success());
      print(e);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    product.value = Get.arguments;

    getCategories();
    category.value =
        product.value.category == "Buah" ? categories.first : categories.last;
    product.value.category = category.value.name;
    change(product, status: RxStatus.success());
  }

  void getCategories() {
    categories.assignAll([
      CategoryModel(
        slug: "Buah",
        name: "Buah",
      ),
      CategoryModel(
        slug: "Sayur",
        name: "Sayur",
      ),
    ]);
  }
}
