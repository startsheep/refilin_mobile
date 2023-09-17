import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/review_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class ReviewProvider extends GetConnect {
  final ApiService apiService = Get.find<ApiService>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpClient.baseUrl = apiService.baseUrl;
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] =
          'Bearer ${LocalStorage.getUser()!['token']}';
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      // Handle authorization errors or other common response modifications if needed
      return response;
    });
  }

  Future<Response> getReviews(String productId) async {
    return await get(
      'review',
      query: {
        'product_id': productId,
        'user': 'true',
      },
      decoder: (body) {
        print("body getReviews: $body");
        if (body['status'] == "SUCCESS") {
          return body['data'].map<ReviewModel>((item) {
            return ReviewModel.fromJson(item);
          }).toList();
        } else {
          return <ReviewModel>[];
        }
      },
    );
  }

  Future<Response> createReview({Map<String, dynamic>? data}) async {
    return await post('review', data);
  }
}
