import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_Icon_button.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/heading_text.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/modules/checkout/views/order_address_view.dart';
import 'package:refilin_mobile/app/modules/checkout/widgets/cart_summary_tile.dart';
import 'package:refilin_mobile/app/modules/checkout/widgets/payment_method_widget.dart';
import 'package:refilin_mobile/app/modules/checkout/widgets/tile_address.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ringkasan Pesanan',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      persistentFooterButtons: [
        RoundedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text(
                "Total Pembayaran",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                controller.order.value.total,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Obx(() {
                return Visibility(
                  visible: controller.isLoading.value,
                  child: Utils.loadingWidget(
                    size: 25,
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: !controller.isLoading.value,
                  child: XButton(
                    width: 120,
                    height: 40,
                    disabledColor: ThemeApp.lightColor,
                    radius: 6,
                    sizeText: 14,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    text: "Buat Pesanan",
                    onPressed: () {
                      // controller.checkout();
                      controller.createOrder();
                      // Get.to(() => const PaymentCodeView());
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Obx(() {
            return Column(
              children: [
                Visibility(
                  visible: controller.currentAddress.value != null,
                  child: TileAddress(
                    address: controller.currentAddress.value ?? AddressModel(),
                  ),
                ),
                Visibility(
                  visible: controller.currentAddress.value == null,
                  child: RoundedContainer(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Pilih Alamat Pengiriman",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        XIconButton(
                            icon: Icons.chevron_right,
                            onTap: () {
                              Get.to(
                                () => const OrderAddressView(),
                                fullscreenDialog: true,
                              );
                            })
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
          const SizedBox(height: 10),
          RoundedContainer(
            color: ThemeApp.lightColor,
            constraints: const BoxConstraints(
              maxHeight: 500,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: controller.order.value.carts!.length,
              itemBuilder: (context, index) {
                final cart = controller.order.value.carts![index];
                return CartSummaryTile(cart: cart);
              },
            ),
          ),
          RoundedContainer(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingText(
                  leftText: "Metode Pembayaran",
                  fontSize: 14,
                  rightText: "Lihat Semua",
                  onPressRightText: () {},
                ),
                PaymentMethod(
                  onChange: (val) {
                    controller.order.value.paymentMethod = val.code!;
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
