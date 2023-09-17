import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/store_model.dart';
import 'package:refilin_mobile/app/providers/store_provider.dart';
import 'package:refilin_mobile/app/providers/success_create_store.dart';
import 'package:refilin_mobile/app/services/location_service.dart';

class StoreCreateController extends GetxController {
  //TODO: Implement StoreCreateController
  final formKey = GlobalKey<FormState>();
  final Rx<StoreModel> store = StoreModel().obs;
  final Rx<XFile> image = XFile("null").obs;
  final addressController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  Future<void> createStore() async {
    await Get.find<StoreProvider>()
        .createStore(
      store: store.value,
      image: image.value.path != "null" ? File(image.value.path) : null,
    )
        .then((res) {
      if (res.body['status'] == "SUCCESS") {
        Get.offAll(() => const StoreCreationSuccessPage());
        Utils.snackMessage(
          title: "Berhasil",
          messages: "Berhasil Membuat Toko",
          type: "success",
        );
      }
    });
  }

  Future<void> getLocation() async {
    Get.find<LocationService>().getCurrentPosition();
    //update store location
    store.update((val) {
      val!.lat = Get.find<LocationService>().latitude.value;
      val.long = Get.find<LocationService>().longitude.value;
    });
    Get.find<LocationService>()
        .getAddressFromCoordinates(
          latitude: store.value.lat,
          longitude: store.value.long,
        )
        .then((value) => {
              addressController.text = value!,
              store.update((val) {
                val!.address = value;
              })
            });
    print("address: ${store.value.address}");
    print("lat: ${store.value.lat}");
    print("long: ${store.value.long}");
  }
}
