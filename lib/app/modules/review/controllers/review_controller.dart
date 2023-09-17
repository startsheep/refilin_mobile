import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/review_model.dart';
import 'package:refilin_mobile/app/providers/review_provider.dart';

class ReviewController extends GetxController
    with StateMixin<List<ReviewModel>> {
  //TODO: Implement ReviewController
  final reviewProvider = Get.find<ReviewProvider>();

  @override
  void onInit() {
    super.onInit();
    getReviews();
  }

  void getReviews() async {
    change([], status: RxStatus.loading());
    final response =
        await reviewProvider.getReviews(Get.arguments.id.toString());
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      change(response.body, status: RxStatus.success());
    } else {
      change([], status: RxStatus.error(response.statusText!));
    }
  }
}
