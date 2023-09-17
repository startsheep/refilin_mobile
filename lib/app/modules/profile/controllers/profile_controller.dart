import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/menu_model.dart';
import 'package:refilin_mobile/app/models/user.dart';
import 'package:refilin_mobile/app/modules/store/bindings/store_binding.dart';
import 'package:refilin_mobile/app/modules/store/views/manage_store_view.dart';
import 'package:refilin_mobile/app/providers/store_provider.dart';
import 'package:refilin_mobile/app/routes/app_pages.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileController extends GetxController with StateMixin {
  //TODO: Implement ProfileController
  RxList<MenuModel> menus = <MenuModel>[].obs;
  final LocalStorage localStorage = LocalStorage();
  UserModel? user;
  final storeService = Get.find<StoreProvider>();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await _isRegisterStore();
    menus.addAll([
      MenuModel(
        title: "Pengaturan Akun",
        icon: Icons.person,
        route: "/profile",
        isActive: true,
      ),
      MenuModel(
        title: "Pesanan Saya",
        icon: MdiIcons.cart,
        route: Routes.ORDER,
        isActive: true,
      ),
      MenuModel(
        title: "Pengaturan Notifikasi",
        icon: Icons.notifications,
        route: "/profile",
        isActive: true,
      ),
      MenuModel(
        title: "Pengaturan Privasi",
        icon: Icons.lock,
        route: "/profile",
        isActive: true,
      ),
      MenuModel(
        title: "Pengaturan Aplikasi",
        icon: Icons.settings,
        route: "/profile",
        isActive: true,
      ),
      MenuModel(
        title: "Keluar",
        icon: Icons.logout,
        onTap: () {
          logout();
        },
        // route: Routes.AUTH
        isActive: true,
      ),
    ]);
    change(menus, status: RxStatus.success());
  }

  Future<void> _isRegisterStore() async {
    await storeService.isRegisStore().then((res) {
      print("isRegistedStore: $res");
      if (res) {
        menus.add(MenuModel(
          title: "Kelola Toko",
          icon: MdiIcons.storeCogOutline,
          // route: Routes.STRORE_CREATE,
          onTap: () {
            Get.to(() => const ManageStoreView(), binding: StoreBinding());
          },
          isActive: true,
        ));
        change(menus, status: RxStatus.success());
      } else {
        menus.add(MenuModel(
          title: "Buka Toko",
          icon: MdiIcons.storePlusOutline,
          route: Routes.STRORE_CREATE,
          isActive: true,
        ));
        change(menus, status: RxStatus.success());
      }
    });
  }

  void logout() {
    Get.offAllNamed(Routes.AUTH);
    LocalStorage.clear();
  }
}

//list menu
