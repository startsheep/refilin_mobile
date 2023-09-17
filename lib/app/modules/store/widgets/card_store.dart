import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/store_model.dart';
import 'package:refilin_mobile/app/modules/store/bindings/store_binding.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_index_controller.dart';
import 'package:refilin_mobile/app/modules/store/views/store_detail_view.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardStore extends StatelessWidget {
  final StoreModel store;

  const CardStore({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final StoreIndexController controller = Get.find();

    return InkWell(
      onTap: () {
        Get.to(
          () => const StoreDetailView(),
          arguments: store,
          binding: StoreBinding(),
        );
      },
      child: RoundedContainer(
        margin: const EdgeInsets.all(5),
        hasBorder: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XPicture(
              imageUrl: store.logo!,
              sizeWidth: Get.width,
              sizeHeight: 120,
              radiusType: RadiusType.none,
            ),
            RoundedContainer(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            store.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        //rating
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            Icon(
                              MdiIcons.star,
                              size: 15,
                              color: ThemeApp.warningColor,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "4.5",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        // 10 produk
                        RoundedContainer(
                          margin: const EdgeInsets.only(right: 5, top: 2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          color: ThemeApp.primaryColor.withOpacity(0.1),
                          child: const Text(
                            "Buka",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // 10 produk
                        // Text(
                        //   "• 10 Produk ",
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.mapMarker,
                          size: 15,
                          color: ThemeApp.dangerColor,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            store.address!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                    future: controller.getDistance(
                      endLatitude: double.parse(store.lat!),
                      endLongitude: double.parse(store.long!),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "${controller.locationService.formatDistance(snapshot.data as double)} darimu",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
