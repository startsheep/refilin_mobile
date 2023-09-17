import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/empty_state_view.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/banner/bindings/banner_binding.dart';
import 'package:refilin_mobile/app/modules/banner/views/create_promo_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/banner_controller.dart';

class BannerView extends GetView<BannerController> {
  const BannerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Promosi Produk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          MdiIcons.plus,
        ),
        onPressed: () {
          Get.to(
            () => const CreatePromoView(),
            binding: BannerBinding(),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedContainer(
            width: Get.width,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Riwayat Promosi Anda ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: controller.obx(
              (banners) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  padding: const EdgeInsets.all(10),
                  itemCount: banners!.length,
                  itemBuilder: (context, index) {
                    return RoundedContainer(
                      width: Get.width,
                      child: Column(
                        children: [
                          XPicture(
                            sizeWidth: Get.width,
                            sizeHeight: 190,
                            imageUrl: banners[index].imagePath,
                          ),
                          RoundedContainer(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                            padding: const EdgeInsets.all(10),
                            radiusType: RadiusType.onlyBottom,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Tanggal Mulai : "),
                                    Text(
                                      banners[index].createdAtFormatted,
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Tanggal Berakhir : "),
                                    Text(
                                      banners[index].experationAtFormatted,
                                    ),
                                  ],
                                ),
                                RoundedContainer(
                                  margin: const EdgeInsets.only(top: 10),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  padding: const EdgeInsets.all(10),
                                  radius: 5,
                                  child:
                                      Text(banners[index].getCountdownTime()),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              onEmpty: Center(
                child: EmptyStateView(
                  icon: MdiIcons.informationOutline,
                  label: "Anda belum memiliki promosi",
                ),
              ),
              onLoading: Center(
                child: Utils.loadingWidget(
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
