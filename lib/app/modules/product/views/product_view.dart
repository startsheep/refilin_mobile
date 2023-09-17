import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/input/category_picker.dart';
import 'package:refilin_mobile/app/common/input/input_currency.dart';
import 'package:refilin_mobile/app/common/input/search_field.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/empty_state_view.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/product/widgets/product_card.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produk',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeApp.darkColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(50),
        //   child: SearchField(),
        // ),
        iconTheme: IconThemeData(
          color: ThemeApp.darkColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showFilter();
            },
            icon: Icon(
              MdiIcons.filterVariant,
              color: ThemeApp.darkColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SearchField(
              onChanged: (val) {
                controller.filter.value.search!.value = val;
              },
            ),
          ),
          Expanded(
            child: controller.obx(
              (products) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = products![index];
                    return ProductCard(
                      product: product,
                      onAddToCart: () {
                        controller.addToCart(product);
                      },
                    ).animate(
                      onInit: (controller) {
                        controller.forward();
                      },
                    ).scaleXY(
                      curve: Curves.easeInOutBack,
                      duration: const Duration(milliseconds: 500),
                      delay: Duration(
                        milliseconds: (100 * index).clamp(100, 500),
                      ),
                    );
                  },
                );
              },
              onEmpty: EmptyStateView(
                icon: MdiIcons.informationOutline,
              ),
              onLoading: Center(
                child: Utils.loadingWidget(size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showFilter() {
    Get.bottomSheet(
      RoundedContainer(
        height: 300,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              "Filter",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RoundedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Harga",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CurrencyInput(
                          label: "Dari",
                          initialValue: "0",
                          onSaved: (val) {},
                          onChanged: (val) {
                            controller.filter.value.prices![0] = int.parse(val);
                            // controller.filter.value.prices![0] = int.parse(val);
                            // print(controller.filter.value.prices![0]);
                            // print(controller.filter.value.prices![0]);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CurrencyInput(
                          label: "Sampai",
                          onChanged: (val) {
                            controller.filter.value.prices![1] = int.parse(val);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RoundedContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kategori",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CategoryPicker(
                    onSelected: (val) {
                      controller.filter.value.category = val;
                    },
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: XButton(
                  height: 40,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  text: "Terapkan",
                  onPressed: () {
                    print(controller.filter.value.toJson());
                    controller.getProducts();
                    Get.back();
                  },
                )),
                const SizedBox(width: 10),
                Expanded(
                  child: XButton(
                    height: 40,
                    hasIcon: true,
                    color: ThemeApp.lightColor,
                    textColor: ThemeApp.darkColor,
                    icon: MdiIcons.refresh,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    text: "Reset",
                    onPressed: () {
                      controller.clearFilter();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
