import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/input/search_field.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/empty_state_view.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/product/bindings/product_binding.dart';
import 'package:refilin_mobile/app/modules/product/controllers/product_strore_controller.dart';
import 'package:refilin_mobile/app/modules/product/views/product_create_view.dart';
import 'package:refilin_mobile/app/modules/product/widgets/product_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductStoreView extends GetView<ProductStoreController> {
  const ProductStoreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Produk di Toko Kamu',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          //icon filter
          IconButton(
            onPressed: () {
              //bottomsheet filter
              //
              showFilterBottomSheet();
            },
            icon: const Icon(MdiIcons.filterVariant),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const ProductCreateView(),
            fullscreenDialog: true,
            binding: ProductBinding(),
          );
        },
        child: const Icon(MdiIcons.plus),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(),
            const SizedBox(height: 10),
            const Text(
              "Daftar Produk di Toko Kamu",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: controller.obx(
                (products) => RefreshIndicator(
                  onRefresh: () async {
                    controller.getProducts();
                  },
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final ProductModel product = products![index];
                      return SlidableAutoCloseBehavior(
                        closeWhenOpened: true,
                        child: ProductTile(
                          product: product,
                          onDelete: () {
                            controller.deleteProduct(product.id!);
                          },
                        ).animate().slideY(
                            duration: const Duration(milliseconds: 300),
                            begin: 1.0,
                            end: 0.0,
                            curve: Curves.easeInBack,
                            delay: Duration(
                                milliseconds: (100 * index).clamp(0, 500))),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: products!.length,
                  ),
                ),
                onEmpty: Center(
                  child: EmptyStateView(
                    icon: MdiIcons.storeOutline,
                    label: "Toko Kamu belum memiliki produk",
                  ),
                ),
                onLoading: Center(child: Utils.loadingWidget()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFilterBottomSheet() {
    Get.bottomSheet(
      RoundedContainer(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          children: [
            Text(
              "Filter",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
