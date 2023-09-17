import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
// ... (other imports)

// Import the newly created widgets
import 'package:refilin_mobile/app/modules/cart/widgets/cart_list_widger.dart';
import 'package:refilin_mobile/app/modules/checkout/views/order_address_view.dart';
import 'package:refilin_mobile/app/modules/order/bindings/order_binding.dart';
import 'package:refilin_mobile/app/routes/app_pages.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Keranjang Mu',
              style: TextStyle(
                fontSize: 16,
                color: ThemeApp.darkColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.mapMarkerOutline,
                    size: 20,
                    color: ThemeApp.darkColor.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Obx(() {
                      return Text(
                        controller.orderAddressController.selectedAddress
                                    .value !=
                                null
                            ? controller.orderAddressController.selectedAddress
                                .value!.region
                            : "Pilih Alamat Pengiriman",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: ThemeApp.darkColor.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const OrderAddressView(),
                          fullscreenDialog: true, binding: OrderBinding());
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: ThemeApp.darkColor.withOpacity(0.5),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Use the CartListWidget here
          CartListWidget(items: controller.carts),

          // ... (bottom bar with total and checkout button)
          RoundedContainer(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Obx(() {
              return Row(
                children: [
                  //checkbox select all
                  Checkbox.adaptive(
                    activeColor: ThemeApp.primaryColor,
                    fillColor: MaterialStateProperty.all(ThemeApp.primaryColor),
                    value: controller.selectAll.value,
                    onChanged: (value) {
                      // controller.selectAll.value = value!;
                      controller.selectAllCarts();
                    },
                    tristate: false,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          // color: ThemeApp.primaryColor,
                          ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const Text(
                    "Pilih Semua",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    Utils.formatCurrency(controller.total.value.toDouble(),
                        locale: "id"),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() {
                    return XButton(
                      width: 90,
                      height: 35,
                      isDisabled: controller.selectedCarts.isEmpty,
                      padding: const EdgeInsets.all(0),
                      hasBorder: true,
                      sizeText: 14,
                      text: "Checkout",
                      onPressed: () {
                        controller.mappingOrder();
                        Get.toNamed(Routes.CHECKOUT,
                            arguments: controller.order);
                      },
                    );
                  }),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
