import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/empty_state_view.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/models/order_modell.dart';
import 'package:refilin_mobile/app/models/store_order_model.dart';
import 'package:refilin_mobile/app/modules/store/controllers/manage_order_controller.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ManageOrderView extends GetView<ManageOrderController> {
  const ManageOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Pesanan',
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
                  text: 'Dibatalkan',
                ),
              ],
              automaticIndicatorColorAdjustment: true,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                ListOrder(),
                ListOrder(status: OrderStatus.pending),
                ListOrder(status: OrderStatus.packing),
                ListOrder(status: OrderStatus.shipping),
                ListOrder(
                  status: OrderStatus.completed,
                ),
                ListOrder(status: OrderStatus.cancelled),
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

class ListOrder extends StatelessWidget {
  final OrderStatus? status;

  ListOrder({Key? key, this.status}) : super(key: key);
  final controller = Get.find<ManageOrderController>();
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
        onEmpty: Center(
          child: EmptyStateView(
            label: "Tidak ada pesanan",
          ),
        ),
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  StoreOrderModel? order;
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
              const XPicture(
                imageUrl: "",
                size: 30,
                assetImage: "assets/icons/avatar.png",
              ),
              const SizedBox(width: 10),
              Text(
                order!.user!.name!,
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
