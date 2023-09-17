import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/profile/widgets/menu_widget.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              RoundedContainer(
                height: 200,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ThemeApp.refilinPrimaryColor,
                    ThemeApp.refilinPrimaryColor.withOpacity(0.5),
                  ],
                ),
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hasBorder: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const XPicture(
                      imageUrl: "",
                      size: 80,
                      assetImage: "assets/icons/avatar.png",
                      radiusType: RadiusType.circle,
                    ),
                    const SizedBox(height: 10),
                    RoundedContainer(
                      padding: const EdgeInsets.all(5),
                      radius: 10,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ThemeApp.refilinPrimaryColor.withOpacity(0.5),
                          ThemeApp.refilinPrimaryColor,
                        ],
                      ),
                      hasBorder: true,
                      child: Text(
                        "${LocalStorage.getUser()!['name']}",
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeApp.lightColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: controller.obx(
                  (state) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        controller.refresh();
                      },
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return FeatureWidget(
                            menu: controller.menus[index],
                          )
                              .animate()
                              .slideX(
                                duration: const Duration(milliseconds: 300),
                                begin: -1.0,
                                end: 0.0,
                                curve: Curves.easeInOutBack,
                                delay: Duration(milliseconds: 100 * index),
                              )
                              .effect(
                                duration: const Duration(milliseconds: 300),
                                delay: Duration(milliseconds: 100 * index),
                              )
                              .animate();
                        },
                        itemCount: controller.menus.length,
                      ),
                    );
                  },
                  onLoading: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const FeatureShimmerWidget();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
