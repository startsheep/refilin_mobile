import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/heading_text.dart';
import 'package:refilin_mobile/app/modules/home/controllers/carousel_controller_controller.dart';
import 'package:refilin_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:refilin_mobile/app/modules/home/widgets/appbar_home.dart';
import 'package:refilin_mobile/app/modules/home/widgets/carousel_conten.dart';
import 'package:refilin_mobile/app/modules/home/widgets/list_categories.dart';
import 'package:refilin_mobile/app/modules/home/widgets/list_category.dart';
import 'package:refilin_mobile/app/modules/home/widgets/product_section_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const AppbarHome(),
              const SizedBox(height: 10),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getFruits();
                    controller.getVegetables();
                    Get.find<CarouselControllerController>().getBanners();
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      CarouselContent(),
                      const SizedBox(height: 10),
                      RoundedContainer(
                        padding: const EdgeInsets.all(10),
                        height: 110,
                        child: Column(
                          children: [
                            HeadingText(
                              leftText: "kategori",
                              rightText: "Lihat Semua",
                              fontSize: 14,
                              onPressRightText: () {},
                            ),
                            const SizedBox(height: 10),
                            ListCategory()
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ProductSectionWidget(
                        title: "Buah Buahan",
                        productList: controller.fruits,
                      ),
                      const SizedBox(height: 10),
                      ProductSectionWidget(
                        title: "Sayur Sayuran",
                        productList: controller.vegetables,
                      ),
                      const SizedBox(height: 10),
                      const ListRecipe()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
