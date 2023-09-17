import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/checkout/views/create_address_view.dart';
import 'package:refilin_mobile/app/modules/checkout/widgets/address_card.dart';
import 'package:refilin_mobile/app/modules/order/bindings/order_binding.dart';

import '../controllers/order_address_controller.dart';

class OrderAddressView extends GetView<OrderAddressController> {
  const OrderAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pilih Alamat',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: controller.obx(
                (addresses) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: addresses!.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Obx(() {
                        return CardAddress(
                          isSelected: RxBool(address.id ==
                              controller.selectedAddress.value?.id),
                          address: address,
                          onDelete: (val) {
                            controller.deleteAddress(val.id!);
                          },
                          onSelected: (address) {
                            controller.selectedAddress(address);
                          },
                        );
                      });
                    },
                  );
                },
                onEmpty: const Center(
                  child: Text("Anda belum memiliki alamat"),
                ),
                onLoading: Center(
                  child: Utils.loadingWidget(
                    size: 20,
                  ),
                ),
                onError: (error) {
                  return Center(
                    child: Text(error!),
                  );
                },
              ),
            ),
            RoundedContainer(
              margin: const EdgeInsets.all(16),
              child: XButton(
                text: "Tambah alamat baru",
                onPressed: () {
                  Get.to(() => const CreateAddressView(),
                      binding: OrderBinding());
                },
              ),
            )
          ],
        ));
  }
}
