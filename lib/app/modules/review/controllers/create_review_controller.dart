import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/models/review_model.dart';
import 'package:refilin_mobile/app/models/user_order_model.dart';
import 'package:refilin_mobile/app/modules/review/views/susscess_review_view.dart';
import 'package:refilin_mobile/app/providers/review_provider.dart';

class CreateReviewController extends GetxController {
  //TODO: Implement CreateReviewController
  final UserOrderModel userOrderModel = Get.arguments as UserOrderModel;
  final List<ProductModel> products = <ProductModel>[];
  final List<ReviewModel> reviews = <ReviewModel>[];
  final reviewProvider = Get.find<ReviewProvider>();
  @override
  void onInit() {
    super.onInit();
    products.addAll(userOrderModel.orderItems!.map((e) => e.product!));
    reviews.addAll(products.map((e) => ReviewModel()));
    //initvalue point
    for (var element in reviews) {
      element.point = 4;
    }
  }

  void createReview() async {
    for (var i = 0; i < products.length; i++) {
      final product = products[i];
      final review = reviews[i];
      print(
          "review: ${review.copyWith(productId: product.id).toCreateReview()}");
      final response = await reviewProvider.createReview(
          data: review.copyWith(productId: product.id).toCreateReview());
      print(review.toCreateReview());
      if (response.statusCode == 200) {
        Get.to(
          () => const SuccessReviewView(),
        );
      }
    }
  }
}
