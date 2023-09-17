import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_detail_controlle.dart';
import 'package:refilin_mobile/app/modules/store/widgets/product_grid.dart';
import 'package:refilin_mobile/app/modules/store/widgets/store_description.dart';
import 'package:refilin_mobile/app/modules/store/widgets/store_header.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class StoreDetailView extends GetView<StoreDetailController> {
  const StoreDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Toko',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: controller.obx(
        (store) {
          return ListView(
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            children: [
              StoreHeader(store: store!),
              StoreDescription(store: store),
              const SizedBox(height: 10),
              const ProductGrid(),
              RoundedContainer(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lokasi Toko",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    RoundedContainer(
                      width: Get.width,
                      height: 200,
                      child: GoogleMap(
                        mapType: MapType.terrain,
                        compassEnabled: true,
                        mapToolbarEnabled: true,
                        onMapCreated: (controller) {
                          // _controller.complete(controller);
                        },
                        circles: {
                          Circle(
                            circleId: const CircleId("store"),
                            center: LatLng(
                              double.parse(store.lat!),
                              double.parse(store.long!),
                            ),
                            radius: 100,
                            fillColor: ThemeApp.primaryColor.withOpacity(0.3),
                            strokeColor: ThemeApp.primaryColor,
                          ),
                          //current location
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(store.lat!),
                            double.parse(store.long!),
                          ),
                          zoom: 14.4746,
                          bearing: 192.8334901395799,
                          tilt: 59.440717697143555,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
        onLoading: Center(
          child: Utils.loadingWidget(size: 40),
        ),
      ),
    );
  }
}
