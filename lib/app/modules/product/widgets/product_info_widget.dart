import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_Icon_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductInfoWidget extends StatelessWidget {
  final ProductModel product;

  const ProductInfoWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      child: Column(
        children: [
          RoundedContainer(
            child: XPicture(
              imageUrl: product.image!,
              sizeWidth: Get.width,
              radius: 0,
              sizeHeight: 250,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RoundedContainer(
                    padding: const EdgeInsets.all(5),
                    color: Colors.grey[200],
                    child: Text(
                      product.priceFormatted,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  RoundedContainer(
                    padding: const EdgeInsets.all(5),
                    color: ThemeApp.lightColor,
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                MdiIcons.star,
                                size: 14,
                                color: Colors.amber,
                              ),
                            ),
                            TextSpan(
                              text: " 4.4 (100)",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " | ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "Terjual 100",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              RoundedContainer(
                child: XIconButton(
                  icon: MdiIcons.bookmarkOutline,
                  color: ThemeApp.primaryColor,
                  supportColor: ThemeApp.lightColor,
                  padding: const EdgeInsets.all(5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
