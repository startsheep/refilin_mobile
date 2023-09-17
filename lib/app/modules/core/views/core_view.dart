import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/modules/payment/views/payment_code_view.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/core_controller.dart';

class CoreView extends GetView<CoreController> {
  const CoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const PaymentCodeView(),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          MdiIcons.camera,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() {
        return AnimatedBottomNavigationBar(
          icons: controller.bottomNavItems.map((e) => e.icon).toList(),
          activeIndex: controller.currentIndex,
          activeColor: controller.currentIndex % 2 == 0
              ? ThemeApp.primaryColor
              : ThemeApp.secondaryColor,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 35,
          rightCornerRadius: 35,
          notchMargin: 10,
          inactiveColor: ThemeApp.neutralColor.withOpacity(0.5),
          backgroundColor: Colors.white,
          onTap: (index) {
            controller.currentIndex = index;
          },
          //other params
        );
      }),
      body: SafeArea(
        child: Obx(() {
          final currentItem =
              controller.bottomNavItems[controller.currentIndex];
          return currentItem.widget;
        }),
      ),
    );
  }
}
