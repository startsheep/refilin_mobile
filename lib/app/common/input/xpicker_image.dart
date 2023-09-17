import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/services/imgae_picker_services.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class XPickerImage extends GetView<PickerController> {
  Function(XFile) onImagePicked;
  String? networkImage;
  double? size;
  XPickerImage({
    this.networkImage,
    required this.onImagePicked,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: size! + 40,
      width: size! + 40,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      hasShadow: false,
      hasBorder: false,
      child: InkWell(
        onTap: () {
          showPicker();
        },
        onLongPress: () {
          showDetail();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            controller.obx(
              (state) {
                return Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: Image.file(File(state.path)).image,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ThemeApp.grayColor.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                );
              },
              onEmpty: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: Utils.handleRequestRadius(
                    radiusType: RadiusType.rounded,
                  ),
                  color: Colors.grey[300],
                  image: networkImage != null
                      ? DecorationImage(
                          image: NetworkImage(networkImage!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/images/placeholder.jpg'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: RoundedContainer(
                  hasBorder: true,
                  width: 40,
                  height: 40,
                  child: Icon(MdiIcons.camera, color: ThemeApp.darkColor),
                ))
          ],
        ),
      ),
    );
  }

  void showDetail() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          color: Colors.transparent,
          height: Get.height,
          width: Get.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // close button in top right corner

              SizedBox(
                width: Get.width,
                child: controller.obx(
                  (state) {
                    return networkImage != null
                        ? Image.network(
                            networkImage!,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(state.path),
                            fit: BoxFit.fill,
                          );
                  },
                  onEmpty: Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: BoxDecoration(
                      borderRadius: Utils.handleRequestRadius(
                        radiusType: RadiusType.rounded,
                      ),
                      color: Colors.grey[300],
                      image: networkImage != null
                          ? DecorationImage(
                              image: NetworkImage(networkImage!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image:
                                  AssetImage('assets/images/placeholder.jpg'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  onLoading: Center(
                    child: Image.asset(
                      'assets/images/placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(
                    MdiIcons.closeCircle,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPicker() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: Colors.white,
        height: 150,
        child: Column(
          children: [
            RoundedContainer(
              width: Get.width,
              height: 50,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                leading: const Icon(MdiIcons.camera),
                title: Text(
                  'Pilih Dari Kamera',
                  style: TextStyle(
                    color: ThemeApp.darkColor,
                  ),
                ),
                onTap: () {
                  controller.pickImageFromCamera().then((value) {
                    if (value.path != 'null' ||
                        value.path != '' ||
                        value.path != null) {
                      onImagePicked(controller.image.value);
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            RoundedContainer(
              width: Get.width,
              height: 50,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                leading: const Icon(MdiIcons.image),
                title: Text(
                  'Pilih Dari Galeri',
                  style: TextStyle(
                    color: ThemeApp.darkColor,
                  ),
                ),
                onTap: () {
                  controller.pickImageFromGallery().then((value) {
                    if (value.path != 'null' ||
                        value.path != '' ||
                        value.path != null) {
                      onImagePicked(controller.image.value);
                    }
                    // onImagePicked(value);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PickerController extends GetxController with StateMixin {
  Rx<XFile> image = XFile('').obs;
  @override
  void onInit() {
    // TODO: implement onInit
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<XFile> pickImageFromGallery() async {
    final pickedFile =
        await Get.find<ImagePickerService>().pickImageFromGallery();
    // change(pickedFile, status: RxStatus.loading());
    if (pickedFile != null) {
      change(pickedFile, status: RxStatus.success());
      image.value = pickedFile;
      Get.back();
      return image.value;
    } else {
      return XFile('');
    }
  }

  Future<XFile> pickImageFromCamera() async {
    final pickedFile =
        await Get.find<ImagePickerService>().pickImageFromCamera();
    // change(pickedFile, status: RxStatus.loading());
    if (pickedFile != null) {
      change(pickedFile, status: RxStatus.success());
      image.value = pickedFile;
      Get.back();
      return image.value;
    } else {
      return XFile('');
    }
  }
}
