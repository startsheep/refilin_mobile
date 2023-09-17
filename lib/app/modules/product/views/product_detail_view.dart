import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/buttons/x_icon_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/heading_text.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/product/controllers/product_detail_controller.dart';
import 'package:refilin_mobile/app/modules/product/widgets/product_info_widget.dart';
import 'package:refilin_mobile/app/modules/product/widgets/store_info_widget.dart';
import 'package:refilin_mobile/app/modules/review/views/review_view.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        RoundedContainer(
          width: Get.width,
          padding: const EdgeInsets.all(10),
          color: ThemeApp.lightColor,
          child: Row(
            children: [
              RoundedContainer(
                child: XIconButton(
                  icon: MdiIcons.phoneSyncOutline,
                  color: ThemeApp.secondaryColor,
                  supportColor: ThemeApp.lightColor,
                  padding: const EdgeInsets.all(5),
                  tooltip: "Hubungi",
                  size: 25,
                ),
              ),
              const SizedBox(width: 5),
              RoundedContainer(
                child: XIconButton(
                  icon: MdiIcons.storeOutline,
                  color: ThemeApp.primaryColor,
                  supportColor: ThemeApp.lightColor,
                  padding: const EdgeInsets.all(5),
                  tooltip: "Lihat Toko",
                  size: 25,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: XButton(
                  onPressed: () {
                    controller.addToCart();
                  },
                  height: 40,
                  sizeText: 14,
                  color: Colors.white,
                  borderColor: ThemeApp.primaryColor,
                  hasBorder: true,
                  hasIcon: true,
                  icon: MdiIcons.cartOutline,
                  textColor: ThemeApp.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  text: "ke Keranjangin",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: XButton(
                  onPressed: () {},
                  height: 40,
                  sizeText: 14,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  text: "Beli Sekarang",
                ),
              ),
            ],
          ),
        ),
      ],
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () async {
            controller.getProduct();
          },
          child: controller.obx(
            (product) {
              return ListView(
                children: [
                  ProductInfoWidget(product: product!.value),
                  // RoundedContainer(
                  //   padding: const EdgeInsets.all(10),
                  //   margin: const EdgeInsets.symmetric(vertical: 10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const SizedBox(height: 10),
                  //       const Text(
                  //         "Deskripsi Produk",
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 10),
                  //       Text(
                  //         product.value.description!,
                  //         style: const TextStyle(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 10),
                  //     ],
                  //   ),
                  // ),
                  RoundedContainer(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StoreInfoWidget(store: product.value.store!),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  RoundedContainer(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadingText(
                          leftText: "Ulasan",
                          rightText: "Lihat Semua",
                          fontSize: 14,
                        ),
                        const SizedBox(height: 10),
                        const ReviewView()
                      ],
                    ),
                  )
                ],
              );
            },
            onLoading: Center(
              child: Utils.loadingWidget(
                size: 80,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
