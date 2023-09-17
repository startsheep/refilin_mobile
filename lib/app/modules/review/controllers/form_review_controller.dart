import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refilin_mobile/app/common/input/xpicker_image.dart';
import 'package:refilin_mobile/app/models/review_model.dart';

class FormReviewController extends GetxController {
  //TODO: Implement FormReviewController
  final PickerController picker = Get.find<PickerController>();
  RxString comment = ''.obs;
  RxDouble rating = 0.0.obs;
  RxList<XFile> images = <XFile>[].obs;
  Rx<ReviewModel> review = ReviewModel(
    point: 4,
  ).obs;
}
