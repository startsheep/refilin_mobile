import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/order_modell.dart';
import 'package:refilin_mobile/app/models/user_order_model.dart';
import 'package:refilin_mobile/app/providers/order_provider.dart';

class ManageOrderController extends GetxController
    with SingleGetTickerProviderMixin, StateMixin {
  late TabController tabController;
  final OrderProvider orderProvider = Get.find<OrderProvider>();
  RxList<UserOrderModel> orders = <UserOrderModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 6, vsync: this);
    tabController.addListener(() {
      getOrders();
    });
    getOrders();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> getOrders() async {
    try {
      final response = await orderProvider.orderInStore(
        status: tabController.index == 0
            ? OrderStatus.values[5]
            : OrderStatus.values[tabController.index - 1],
      );
      print("response order: ${response.body}");
      if (response.status.hasError) {
        change(null, status: RxStatus.error(response.statusText!));
      } else {
        if (response.body.isEmpty) {
          change(null, status: RxStatus.empty());
          return;
        }
        change(response.body, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
