import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/home/controllers/carousel_controller_controller.dart';

class CarouselContent extends GetView<CarouselControllerController> {
  CarouselContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: Get.width,
      height: 150,
      hasBorder: true,
      // padding: const EdgeInsets.all(10.0),
      child: controller.obx((banners) {
        return CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: Get.width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(banners![index].imagePath!),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            padEnds: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 2000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            // viewportFraction: 1.0,
            aspectRatio: 1.0,
            onPageChanged: (index, reason) {
              // controller.current = index;
            },
          ),
        );
      },
          onLoading: Center(
            child: Utils.loadingWidget(size: 30),
          )),
    );
  }

  List<String> images = [
    "banner_1.jpg",
    "banner_2.jpg",
    "banner_3.png",
  ];
}
