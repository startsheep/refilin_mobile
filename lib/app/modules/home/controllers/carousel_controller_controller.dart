import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/banner_model.dart';
import 'package:refilin_mobile/app/providers/banner_provider.dart';

class CarouselControllerController extends GetxController
    with StateMixin<List<BannerModel>> {
  final bannerProvider = Get.find<BannerProvider>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getBanners() async {
    await bannerProvider.getBanners().then((res) {
      if (res.body['status'] == "SUCCESS") {
        if (res.body['data'].isEmpty) {
          change([], status: RxStatus.empty());
          return;
        }
        change(res.body['data'], status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    });
  }
}
