import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/modules/cart/views/cart_view.dart';
import 'package:refilin_mobile/app/modules/home/views/home_view.dart';
import 'package:refilin_mobile/app/modules/profile/views/profile_view.dart';
import 'package:refilin_mobile/app/modules/store/views/store_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CoreController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  final ScrollController scrollController = ScrollController();
  bool isVisible = true;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    print(scrollController.position.userScrollDirection);
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isVisible) {
        isVisible = false;
      }
    } else {
      if (!isVisible) {
        isVisible = true;
      }
    }
  }

  final List<BottomNavItem> _bottomNavItems = [
    BottomNavItem(
      title: "Home",
      icon: MdiIcons.barn,
      widget: const HomeView(),
      activeIcon: MdiIcons.barn,
      isActive: true.obs, // Make isActive an RxBool
    ),
    BottomNavItem(
      title: "Toko",
      icon: MdiIcons.store,
      widget: const StoreView(),
      activeIcon: MdiIcons.storeOutline,
      isActive: false.obs, // Make isActive an RxBool
    ),
    BottomNavItem(
      title: "Cart",
      icon: MdiIcons.cart,
      widget: const CartView(),
      activeIcon: MdiIcons.cartOutline,
      isActive: false.obs, // Make isActive an RxBool
    ),
    BottomNavItem(
      title: "Profile",
      icon: MdiIcons.account,
      widget: const ProfileView(),
      activeIcon: MdiIcons.accountOutline,
      isActive: false.obs, // Make isActive an RxBool
    ),
  ];

  List<BottomNavItem> get bottomNavItems => _bottomNavItems;

  int get currentIndex => _currentIndex.value;
  set currentIndex(int value) {
    _currentIndex.value = value;
  }

  void setActiveBottomNavItem(BottomNavItem item) {
    for (final navItem in _bottomNavItems) {
      navItem.isActive.value = navItem == item;
    }
  }

  @override
  void onClose() {}
}

class BottomNavItem {
  final String title;
  final IconData icon;
  final Widget widget;
  final IconData? activeIcon;
  final RxBool isActive; // Change to RxBool

  BottomNavItem({
    required this.title,
    required this.icon,
    required this.widget,
    this.activeIcon,
    required this.isActive, // Change the type to RxBool
  });
}
