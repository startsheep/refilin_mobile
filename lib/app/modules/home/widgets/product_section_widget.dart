import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/empty_state_view.dart';
import 'package:refilin_mobile/app/common/ui/heading_text.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:refilin_mobile/app/modules/home/widgets/card_product.dart';
import 'package:refilin_mobile/app/modules/product/bindings/product_binding.dart';
import 'package:refilin_mobile/app/modules/product/views/product_view.dart';

class ProductSectionWidget extends GetView<HomeController> {
  final String title;
  final List<ProductModel> productList;

  const ProductSectionWidget({
    Key? key,
    required this.title,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 220,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          HeadingText(
            leftText: title,
            fontSize: 14,
            rightText: "Lihat Semua",
            onPressRightText: () {
              Get.to(
                () => const ProductView(),
                binding: ProductBinding(),
                fullscreenDialog: true,
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: controller.obx(
              (state) => GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: productList.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return CardProduct(
                    product: product,
                    onAddToCart: () {
                      controller.addToCart(product: product);
                    },
                  ).animate().slideX(
                        duration: const Duration(milliseconds: 500),
                        begin: -1,
                        end: 0,
                        delay: Duration(milliseconds: (index + 1) * 100),
                      );
                },
              ),
              onLoading: Center(
                child: Utils.loadingWidget(
                  size: 30,
                ),
              ),
              onEmpty: Center(
                child: EmptyStateView(
                  icon: Icons.info_outline,
                  label: "Belum ada produk",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
