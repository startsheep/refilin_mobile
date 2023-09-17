import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/input/x_field.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/create_address_controller.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class CreateAddressView extends GetView<CreateAddressController> {
  const CreateAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Alamat Baru',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      persistentFooterButtons: [
        RoundedContainer(
          margin: const EdgeInsets.all(16),
          child: XButton(
            text: "Simpan",
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.formKey.currentState!.save();
                controller.saveAddress();
              }
            },
          ),
        )
      ],
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            RoundedContainer(
              hasBorder: true,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informasi Penerima",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  XTextField(
                    hintText: "Nama Penerima",
                    // controller: controller.nameController,
                    onSave: (val) {
                      controller.address.value.contactName = val;
                    },
                    validator: (val) {
                      return val!.isEmpty ? "Harap isi nama penerima" : null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  XTextField(
                    hintText: "Nomor Telepon",
                    // controller: controller.phoneController,
                    onSave: (val) {
                      controller.address.value.contactPhone = val;
                    },
                    validator: (val) {
                      return val!.isEmpty ? "Harap isi nomor telepon" : null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedContainer(
              hasBorder: true,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "informasi Alamat",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return DropdownButtonFormField<Province>(
                      onChanged: (Province? newValue) {
                        controller.province = Province().obs;
                        if (newValue is Province) {
                          // controller.district.value = District();
                          // controller.village.value = Village();
                          // controller.regency.value = Regency();
                          controller.province.value = newValue;
                          controller.regencies.clear();
                          controller.getRegency(newValue.id!);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Provinsi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      itemHeight: 50,
                      items: controller.provinces.map((Province province) {
                        return DropdownMenuItem<Province>(
                          value: province,
                          alignment: Alignment.centerLeft,
                          child: Text(province.name!),
                        );
                      }).toList(),
                      validator: (val) {
                        if (val == null) {
                          return "Harap pilih provinsi";
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Visibility(
                      visible: controller.province.value.id != null,
                      child: DropdownButtonFormField<Regency>(
                        items: controller.regencies.map((Regency regency) {
                          return DropdownMenuItem<Regency>(
                            value: regency,
                            alignment: Alignment.centerLeft,
                            child: Text(regency.name!),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Kota/Kabupaten",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (val) {
                          controller.regency.value = val!;
                          controller.getDistrict(val.id!);
                        },
                        validator: (val) {
                          if (val == null) {
                            return "Harap pilih kota/kabupaten";
                          }
                          return null;
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Visibility(
                      visible: controller.regency.value.id != null,
                      child: DropdownButtonFormField<District>(
                        items: controller.districts.map((District district) {
                          return DropdownMenuItem<District>(
                            value: district,
                            alignment: Alignment.centerLeft,
                            child: Text(district.name!),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Kecamatan",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (val) {
                          controller.district.value = val!;
                          controller.getVillage(val.id!);
                        },
                        validator: (value) {
                          return value == null ? "Harap pilih kecamatan" : null;
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Visibility(
                      visible: controller.district.value.id != null,
                      child: DropdownButtonFormField<Village>(
                        items: controller.villages.map((Village village) {
                          return DropdownMenuItem<Village>(
                            value: village,
                            alignment: Alignment.centerLeft,
                            child: Text(village.name!),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Desa/Kelurahan",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (val) {
                          controller.village.value = val!;
                          controller.getVillage(val.id!);
                        },
                        validator: (value) =>
                            value == null ? "Harap pilih desa/kelurahan" : null,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  XTextField(
                    hintText: "Alamat Lengkap",
                    // controller: controller.addressController,
                    maxLines: 3,

                    onSave: (val) {
                      controller.address.value.address = val;
                    },
                    validator: (val) {
                      return val!.isEmpty ? "Harap isi alamat lengkap" : null;
                    },
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // XTextField(
                  //   hintText: "Kode Pos",
                  //   keyboardType: TextInputType.number,
                  //   onSave: (val) {
                  //     controller.address.value.contactName = val!;
                  //   },
                  //   validator: (val) {
                  //     return val!.isEmpty ? "Harap isi kode pos" : null;
                  //   },
                  // )
                ],
              ),
            ),
            RoundedContainer(
              hasBorder: true,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pengaturan",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Jadikan Alamat Utama",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Obx(() {
                        return Switch(
                          activeColor: ThemeApp.primaryColor,
                          value: controller.address.value.isDefault!.value == 1,
                          onChanged: (value) {
                            controller.address.value.isDefault!.value =
                                value ? 1 : 0;
                          },
                        );
                      })
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
