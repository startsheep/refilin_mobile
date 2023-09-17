import 'package:get/get.dart';

import 'package:refilin_mobile/app/modules/home/controllers/carousel_controller_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarouselControllerController>(
      () => CarouselControllerController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
