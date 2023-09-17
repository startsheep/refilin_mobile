import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refilin_mobile/app/models/banner_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class BannerProvider extends GetConnect {
  final apiService = Get.find<ApiService>();
  @override
  void onInit() {
    // TODO: implement onInit
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
    super.onInit();
    httpClient.defaultDecoder = (responseBody) {
      final map = responseBody as Map<String, dynamic>;
      print("default decoder product: $map");
      if (map['status'] == 'ERROR') {
        throw map['message'];
      }
      if (map['data'] is Map<String, dynamic>) {
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': BannerModel.fromJson(map['data']),
        };
      } else if (map['data'] is List) {
        print("map['data'] is List");
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': map['data']
              .map<BannerModel>((item) => BannerModel.fromJson(item))
              .toList(),
        };
      }
      throw 'Invalid response format';
    };
  }

  Future<Response> createBanner({
    BannerModel? banner,
    XFile? image,
  }) async {
    //multipart request
    final formdata = FormData({
      'document_banner': MultipartFile(
        image!.path,
        filename: image.name.split('/').last,
      ),
      'bank_code': banner!.bankCode,
      "amount": 10000,
    });
    return await post(
      'banner',
      formdata,
    );
  }

  Future<Response> getBanners() async {
    return await get('banner');
  }

  Future<Response> getUserBanners() async {
    return await get('banner',
        query: {"user_id": LocalStorage.getUser()!['id'].toString()});
  }
}
