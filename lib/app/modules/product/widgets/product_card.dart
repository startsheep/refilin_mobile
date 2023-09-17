import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_icon_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/product/bindings/product_binding.dart';
import 'package:refilin_mobile/app/modules/product/views/product_detail_view.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.onAddToCart,
    required this.product,
  });

  final ProductModel product;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => const ProductDetailView(),
          binding: ProductBinding(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          arguments: product,
          duration: const Duration(milliseconds: 500),
        );
      },
      child: RoundedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: XPicture(
              sizeWidth: Get.width,
              imageUrl: product.image!,
              radiusType: RadiusType.none,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          RoundedContainer(
                            hasBorder: true,
                            color: ThemeApp.lightColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            child: Text(
                              product.priceFormatted,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          //RATING
                          Row(
                            children: [
                              Icon(
                                MdiIcons.star,
                                size: 15,
                                color: ThemeApp.warningColor,
                              ),
                              const Text(
                                "4.5",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  XIconButton(
                    supportColor: ThemeApp.primaryColor.withOpacity(0.5),
                    icon: MdiIcons.cartPlus,
                    padding: const EdgeInsets.all(5),
                    size: 20,
                    onTap: () {
                      onAddToCart?.call();
                      // controller.addToCart(product: product);
                    },
                    color: ThemeApp.primaryColor,
                  ),
                ],
              ),
            ),
            RoundedContainer(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Row(
                children: [
                  XPicture(
                    imageUrl: product.store!.logo!,
                    size: 20,
                    radius: 5,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    product.store!.name!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  //DISTANCE
                  Row(
                    children: [
                      Icon(
                        MdiIcons.mapMarker,
                        size: 15,
                        color: ThemeApp.dangerColor,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "1.2 km",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
