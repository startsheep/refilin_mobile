import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/banner_model.dart';
import 'package:refilin_mobile/app/modules/banner/controllers/banner_controller.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/payment_method_controller.dart';
import 'package:refilin_mobile/app/modules/payment/views/payment_code_view.dart';
import 'package:refilin_mobile/app/providers/banner_provider.dart';

class CreatePromoController extends GetxController {
  final bannerProvider = Get.find<BannerProvider>();
  BannerModel banner = BannerModel();
  final Rx<XFile?> image = XFile("").obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print("CreatePromoController onInit");
    setInactivePaymentCOD();
  }

  void setInactivePaymentCOD() {
    print("setInactivePaymentCOD");
    final paymentMethodController = Get.find<PaymentMethodController>();
    paymentMethodController.paymentList
        .removeWhere((paymentMethod) => paymentMethod.code == "COD");
  }

  Future<void> createBanner() async {
    try {
      isLoading.value = true;
      final response =
          await bannerProvider.createBanner(banner: banner, image: image.value);
      if (response.body['status'] == "SUCCESS") {
        isLoading.value = false;
        showSuccessSnackbar("Berhasil Membuat Promo");
        refreshBannersList();
      }
    } catch (e) {
      isLoading.value = false;
      print("error create banner: $e");
    }
  }

  void showSuccessSnackbar(String message) {
    Utils.snackMessage(
      title: "Berhasil",
      messages: message,
      type: "success",
    );
  }

  void refreshBannersList() {
    Get.to(
      const PaymentCodeView(),
    );
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.find<BannerController>().getBanners();
    });
  }
}
