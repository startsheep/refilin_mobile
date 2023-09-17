import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/input/input_currency.dart';
import 'package:refilin_mobile/app/common/input/x_field.dart';
import 'package:refilin_mobile/app/common/input/xpicker_image.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/product/controllers/product_create_controller.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductCreateView extends GetView<ProductCreateController> {
  const ProductCreateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Produk Baru',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: RoundedContainer(
          color: ThemeApp.lightColor,
          // height: Get.height,
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                XPickerImage(
                  onImagePicked: (val) {
                    controller.image.value = val;
                  },
                  size: 100,
                ),
                const SizedBox(height: 10),
                XTextField(
                  hintText: "masukkan nama produk",
                  labelText: "Nama Produk",
                  prefixIcon: MdiIcons.labelOutline,
                  onSave: (val) {
                    controller.product.value.name = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Nama produk tidak boleh kosong";
                    }
                    if (val.length < 3) {
                      return "Nama produk minimal 3 karakter";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CurrencyInput(
                  label: "Harga",
                  initialValue: "0",
                  prefixIcon: MdiIcons.cash,
                  onSaved: (val) {
                    controller.product.value.price = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Harga produk tidak boleh kosong";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                XTextField(
                  hintText: "Masukkan deskripsi produk",
                  labelText: "Deskripsi Produk",
                  prefixIcon: MdiIcons.text,
                  onSave: (val) {
                    controller.product.value.description = val;
                  },
                  maxLines: 5,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Deskripsi produk tidak boleh kosong";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                RoundedContainer(
                  padding: const EdgeInsets.all(10),
                  width: Get.width,
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Kategori Produk",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(child: Obx(() {
                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                          itemCount: controller.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final category = controller.categories[index];
                            return InkWell(
                              onTap: () {
                                // controller.selectCategory(category);
                                controller.product.value.category =
                                    category.name;
                                controller.category.value = category;
                              },
                              child: Obx(() {
                                return RoundedContainer(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  hasBorder: true,
                                  width: Get.width / 3,
                                  color: category.name ==
                                          controller.category.value.name
                                      ? ThemeApp.secondaryColor
                                      : ThemeApp.lightColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        category.slug!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: category.name ==
                                                  controller.category.value.name
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          },
                        );
                      })),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                XTextField(
                  hintText: "Stok Produk",
                  keyboardType: TextInputType.number,
                  prefixIcon: MdiIcons.cashRegister,
                  onSave: (val) {
                    controller.product.value.stock = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Stok produk tidak boleh kosong";
                    }

                    return null;
                  },
                  maxLines: 1,
                ),
                // const Spacer(),
                const SizedBox(height: 20),
                controller.obx(
                  (context) {
                    return XButton(
                      text: "Simpan",
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          controller.formKey.currentState!.save();
                          controller.createProduct();
                        }
                      },
                    );
                  },
                  onEmpty: const SizedBox.shrink(),
                  onLoading: Center(
                    child: Utils.loadingWidget(size: 50),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
