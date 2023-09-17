import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_Icon_button.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/buttons/x_outline_button.dart';
import 'package:refilin_mobile/app/common/input/x_field.dart';
import 'package:refilin_mobile/app/common/input/xpicker_image.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/x_appbar.dart';
import 'package:refilin_mobile/app/modules/store/controllers/store_create_controller.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreCreateView extends GetView<StoreCreateController> {
  const StoreCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            XAppBar(
              title: "Buat Toko",
              rightIcon: Icons.close,
              onTapRightIcon: () {
                Get.back();
              },
              hasRightIcon: true,
            ),
            Expanded(
              child: RoundedContainer(
                hasBorder: true,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Form(
                  key: controller.formKey,
                  child: ListView(
                    children: [
                      RoundedContainer(
                        hasBorder: true,
                        child: XPickerImage(
                          onImagePicked: (image) {
                            controller.image.value = image;
                          },
                          size: 100,
                        ),
                      ),
                      const SizedBox(height: 10),
                      XTextField(
                        labelText: "Nama Toko",
                        hintText: "Masukkan nama toko",
                        onSave: (val) {
                          controller.store.value.name = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nama toko tidak boleh kosong";
                          }
                          if (value.length < 3) {
                            return "Nama toko minimal 3 karakter";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      XTextField(
                        labelText: "Deskripsi Toko",
                        hintText: "Masukkan deskripsi toko",
                        minLines: 1,
                        maxLines: 3,
                        onSave: (val) {
                          controller.store.value.description = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Deskripsi toko tidak boleh kosong";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: XTextField(
                              labelText: "Alamat Toko",
                              hintText: "Masukkan alamat toko",
                              minLines: 1,
                              maxLines: 3,
                              controller: controller.addressController,
                              onSave: (val) {
                                controller.store.value.address = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Alamat toko tidak boleh kosong";
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          XIconButton(
                            icon: MdiIcons.mapMarker,
                            onTap: () async {
                              await controller.getLocation();
                            },
                            color: Theme.of(context).primaryColor,
                            size: 30,
                            supportColor: ThemeApp.darkColor,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        return Row(
                          children: [
                            Expanded(
                              child: RoundedContainer(
                                hasBorder: true,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Latitude"),
                                    Text(controller.store.value.lat.toString()),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: RoundedContainer(
                                hasBorder: true,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Longitude"),
                                    Text(
                                        controller.store.value.long.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 10),
                      XOutlineButton(
                        text: "Cocokan lokasi saat ini",
                        hasIcon: true,
                        icon: Icons.location_on,
                        onPressed: () async {
                          await controller.getLocation();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RoundedContainer(
              padding: const EdgeInsets.all(10),
              child: XButton(
                text: "Simpan",
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    controller.formKey.currentState!.save();
                    await controller.createStore();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
