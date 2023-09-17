import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_Icon_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/product/bindings/product_binding.dart';
import 'package:refilin_mobile/app/modules/product/views/product_detail_view.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardProduct extends GetView {
  ProductModel product;
  VoidCallback onAddToCart;
  CardProduct({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed("/product/detail", arguments: product);
        Get.to(
          () => const ProductDetailView(),
          binding: ProductBinding(),
          arguments: product,
          fullscreenDialog: true,
          popGesture: true,
          curve: Curves.easeIn,
          preventDuplicates: false,
        );
      },
      child: RoundedContainer(
        hasBorder: true,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            XPicture(
              imageUrl: product.image,
              sizeWidth: Get.width,
              radius: 0,
            ),
            RoundedContainer(
              width: Get.width,
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          product.priceFormatted,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  XIconButton(
                    size: 20,
                    supportColor: ThemeApp.refilinPrimaryColor.withOpacity(0.5),
                    icon: MdiIcons.cartOutline,
                    color: Colors.white,
                    onTap: () {
                      onAddToCart();
                    },
                    backgroundColor: ThemeApp.refilinPrimaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
