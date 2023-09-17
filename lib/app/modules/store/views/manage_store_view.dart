import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/profile/widgets/menu_widget.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_controller.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ManageStoreView extends GetView<StoreController> {
  const ManageStoreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // controller.getStores();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Kelola Toko',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // Get.toNamed(Routes.STORE_CREATE);
              },
              icon: const Icon(MdiIcons.storeCogOutline),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: controller.obx(
            (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedContainer(
                    // radiusType: RadiusType.none,
                    // hasBorder: true,
                    padding: const EdgeInsets.all(5),
                    hasShadow: true,
                    child: XPicture(
                      size: Get.width,
                      sizeHeight: 200,
                      // radiusType: RadiusType.none,
                      imageUrl: controller.store.value.logo,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RoundedContainer(
                    hasBorder: true,
                    child: ListTile(
                      horizontalTitleGap: 5,
                      // dense: true,
                      // isThreeLine: true,
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(
                        controller.store.value.name ?? "Nama Toko",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                MdiIcons.mapMarkerOutline,
                                size: 14,
                                color: ThemeApp.dangerColor,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  controller.store.value.address ??
                                      "Alamat Toko",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Deskcripsi",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ExpandableText(
                            controller.store.value.description!,
                            expandText: "Lihat selengkapnya",
                            collapseText: "Tutup",
                            maxLines: 3,
                            animation: true,
                            linkStyle: TextStyle(
                              color: ThemeApp.darkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      trailing: RoundedContainer(
                        width: 50,
                        height: 50,
                        color: ThemeApp.warningColor.withOpacity(0.2),
                        hasBorder: true,
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "4.5",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ThemeApp.darkColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: controller.featureStore.length,
                    itemBuilder: (context, index) {
                      final feature = controller.featureStore[index];
                      return FeatureWidget(
                        menu: feature,
                      ).animate().slideX(
                            duration: const Duration(milliseconds: 400),
                            begin: index.isEven ? 1.0 : -1.0,
                            end: 0.0,
                            curve: Curves.easeInBack,
                            delay: Duration(milliseconds: 400 * index),
                          );
                    },
                  ))
                ],
              ).animate().fadeIn(
                    duration: const Duration(milliseconds: 400),
                    begin: 0.0,
                    curve: Curves.easeInBack,
                  );
            },
            onLoading: Center(
              child: Utils.loadingWidget(
                size: 50,
              ),
            ),
          ),
        ));
  }
}
