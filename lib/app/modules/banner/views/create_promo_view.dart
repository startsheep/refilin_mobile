import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/input/xpicker_image.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/banner/controllers/create_promo_controller.dart';
import 'package:refilin_mobile/app/modules/checkout/widgets/payment_method_widget.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class CreatePromoView extends GetView<CreatePromoController> {
  const CreatePromoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Promo Baru',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      persistentFooterButtons: [
        RoundedContainer(
          width: Get.width,
          padding: const EdgeInsets.all(5),
          child: Obx(() {
            return Column(
              children: [
                Visibility(
                    visible: controller.isLoading.value,
                    child: Center(
                      child: Utils.loadingWidget(size: 30),
                    )),
                Obx(() {
                  return Visibility(
                    visible: !controller.isLoading.value,
                    child: XButton(
                      text: "Buat Promo",
                      onPressed: () {
                        controller.createBanner();
                      },
                      isDisabled: controller.image.value!.path == "" ||
                          controller.banner.bankCode == null,
                    ),
                  );
                }),
              ],
            );
          }),
        )
      ],
      body: ListView(
        children: [
          RoundedContainer(
            margin: const EdgeInsets.all(10),
            width: Get.width,
            height: 190,
            hasBorder: true,
            child: XPickerImage(
              size: Get.width,
              onImagePicked: (val) {
                controller.image.value = val;
              },
            ),
          ),
          RoundedContainer(
            width: Get.width,
            padding: const EdgeInsets.all(10),
            radius: 5,
            margin: const EdgeInsets.all(10),
            color: ThemeApp.warningColor,
            child: const Text(
              "Pastikan Gambar yang diupload 180x90 cm",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          RoundedContainer(
            padding: const EdgeInsets.all(10),
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ketentuan",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Promosi Banner Atau Produk Berlaku 1 Minggu Setelah Dibayar, Setelah satu minggu promo akan dihilangkan dari halaman utama",
                ),
                RoundedContainer(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  color: ThemeApp.infoColor,
                  radius: 5,
                  padding: const EdgeInsets.all(10),
                  child: const Text("Hargea Promosi 5.000 / Minggu"),
                )
              ],
            ),
          ),
          RoundedContainer(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Metode Pembayaran",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PaymentMethod(
                  onChange: (val) {
                    controller.banner.bankCode = val.code;
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
