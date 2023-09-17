import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/models/store_model.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreHeader extends StatelessWidget {
  final StoreModel store;

  const StoreHeader({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        XPicture(
          imageUrl: store.logo!,
          sizeWidth: Get.width,
          sizeHeight: 150,
        ),
        RoundedContainer(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          hasBorder: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    Text(
                      store.name!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      MdiIcons.star,
                      color: ThemeApp.warningColor,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "4.5",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    Icon(
                      MdiIcons.mapMarker,
                      color: ThemeApp.dangerColor,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        store.address!,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  XPicture(
                    imageUrl: store.user!.avatar ?? "",
                    size: 20,
                    assetImage: "assets/images/avatar.png",
                  ),
                  const SizedBox(width: 5),
                  Text(
                    store.user!.name!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),

                  ///phone number
                  Text(
                    store.user!.phone ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
