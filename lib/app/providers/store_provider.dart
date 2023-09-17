import 'dart:io';

import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/store_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class StoreProvider extends GetConnect {
  final ApiService apiService = Get.find<ApiService>();

  @override
  void onInit() {
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
    httpClient.defaultDecoder = (responseBody) {
      print("responseBody store provider: $responseBody");
      final map = responseBody as Map<String, dynamic>;
      if (map['status'] == 'ERROR') {
        throw map['message'];
      }
      if (map['data'] == null) {
        return {
          'status': map['status'],
          'message': map['message'],
          'data': null,
        };
      }
      if (map['data'] is Map<String, dynamic>) {
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': map['data'] != null ? StoreModel.fromJson(map['data']) : null,
        };
      } else if (map['data'] is List) {
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': map['data']
              .map<StoreModel>((item) => StoreModel.fromJson(item))
              .toList(),
        };
      }
      throw 'Invalid response format';
    };
  }

  Future<Response> getStores({String? search}) async {
    return await get('store', query: {
      'search': search,
    });
  }

  Future<Response> createStore({
    required StoreModel store,
    File? image,
  }) async {
    print(image?.path.split('/').last);
    if (image != null) {
      //form data
      final formData = FormData({
        'name': store.name,
        'description': store.description,
        'address': store.address,
        'lat': store.lat ?? '-',
        'long': store.long ?? '-',
        'document_logo':
            MultipartFile(image, filename: image.path.split('/').last),
      });
      return await post(
        'store',
        formData,
      );
    }
    return await post(
      'store',
      store.toSaveJson(),
    );
  }

  Future<Response> getStore({int? storeId, bool? userStore}) async {
    final uri = Uri.parse('store/$storeId').replace(queryParameters: {
      'user': userStore.toString(),
    });
    return await get(uri.toString());
  }

  Future<Response> updateStore({required StoreModel store, File? image}) async {
    if (image != null) {
      //form data
      final formData = FormData({
        'name': store.name,
        'description': store.description,
        'address': store.address,
        'lat': store.lat ?? '-',
        'long': store.long ?? '-',
        'document_logo':
            MultipartFile(image, filename: image.path.split('/').last),
      });
      return await put(
        'store/${store.id}',
        formData,
      );
    }
    return await put(
      'store/${store.id}',
      store.toSaveJson(),
    );
  }

  Future<Response> deleteStore(String? storeId) async {
    return await delete(
      'store/$storeId',
    );
  }

  Future<Response> getUserStore() async {
    return await post('user/check/store', {});
  }

  Future<bool> isRegisStore() async {
    final response = await post('user/check/store', {});
    if (response.body['status'] == 'SUCCESS') {
      return true;
    } else {
      return false;
    }
  }
}
