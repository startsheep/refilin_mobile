import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/empty_state_view.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/order_modell.dart';
import 'package:refilin_mobile/app/models/user_order_model.dart';
import 'package:refilin_mobile/app/modules/payment/views/payment_code_view.dart';
import 'package:refilin_mobile/app/modules/review/bindings/review_binding.dart';
import 'package:refilin_mobile/app/modules/review/views/create_review_view.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanasn',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(MdiIcons.magnify),
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Column(
        children: [
          RoundedContainer(
            height: 60,
            child: TabBar(
              labelColor: ThemeApp.darkColor,
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              indicatorColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              controller: controller.tabController,
              splashBorderRadius: BorderRadius.circular(10),
              tabs: const [
                TabWithIcon(
                  icon: MdiIcons.formatListBulleted,
                  text: 'Semua',
                ),
                TabWithIcon(
                  icon: MdiIcons.clockOutline,
                  text: 'Belum Bayar',
                ),
                TabWithIcon(
                  icon: MdiIcons.packageVariant,
                  text: 'Dikemas',
                ),
                TabWithIcon(
                  icon: MdiIcons.truckDeliveryOutline,
                  text: 'Dikirim',
                ),
                TabWithIcon(
                  icon: MdiIcons.check,
                  text: 'Selesai',
                ),
                TabWithIcon(
                  icon: MdiIcons.cancel,
                  text: 'dibatalkan',
                ),
                //cancel
              ],
              automaticIndicatorColorAdjustment: true,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                MyOrderView(),
                MyOrderView(status: OrderStatus.pending),
                MyOrderView(status: OrderStatus.packing),
                MyOrderView(status: OrderStatus.shipping),
                MyOrderView(status: OrderStatus.completed),
                MyOrderView(status: OrderStatus.cancelled),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const TabWithIcon({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}

class MyOrderView extends StatelessWidget {
  final OrderStatus? status;

  MyOrderView({Key? key, this.status}) : super(key: key);
  final OrderController controller = Get.find<OrderController>();
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: Get.height,
      child: controller.obx(
        (orders) {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              return OrderItemWidget(
                status: status,
                order: orders[index],
              );
            },
          );
        },
        onLoading: Center(
          child: Utils.loadingWidget(
            size: 30,
          ),
        ),
        onEmpty: Center(
          child: EmptyStateView(
            icon: MdiIcons.orderNumericAscending,
            label: "Kamu belum memiliki pesanan",
          ),
        ),
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  UserOrderModel? order;
  OrderStatus? status;
  OrderItemWidget({Key? key, this.order, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      hasBorder: true,
      child: Column(
        children: [
          Row(
            children: [
              XPicture(
                imageUrl: order!.store!.logo!,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                order!.store!.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              RoundedContainer(
                radius: 5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: ThemeApp.lightColor,
                child: Text(
                  "Status",
                  style: TextStyle(
                    color: ThemeApp.darkColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RoundedContainer(
            constraints: const BoxConstraints(
              maxHeight: 400,
            ),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: order!.orderItems!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = order!.orderItems![index];
                return ListTile(
                  leading: XPicture(
                    imageUrl: item.product!.image!,
                    size: 40,
                  ),
                  title: Text(
                    item.product!.name!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${item.qty!}x",
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    item.product!.priceFormatted,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${order!.totalQty} Item , Total : ${order!.totalPriceFormatted}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Visibility(
                    visible: order!.orderItems!.first.status == 0,
                    child: XButton(
                      height: 30,
                      radius: 5,
                      width: 110,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      onPressed: () {
                        Get.to(() => const PaymentCodeView(), arguments: order);
                      },
                      text: "Bayar Sekarang",
                      sizeText: 12,
                    ),
                  ),
                  Visibility(
                    visible: order!.orderItems!.first.status == 3,
                    child: XButton(
                      height: 30,
                      radius: 5,
                      color: ThemeApp.lightColor,
                      borderColor: ThemeApp.primaryColor,
                      textColor: ThemeApp.primaryColor,
                      width: 110,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      onPressed: () {
                        Get.to(
                          () => const CreateReviewView(),
                          arguments: order,
                          binding: ReviewBinding(),
                        );
                      },
                      hasBorder: true,
                      borderWidth: 2,
                      text: "Beri ulasan",
                      sizeText: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
