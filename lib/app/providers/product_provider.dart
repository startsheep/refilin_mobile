import 'dart:io';

import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/product_filter_model.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class ProductProvider extends GetConnect {
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
          'data': ProductModel.fromJson(map['data']),
        };
      } else if (map['data'] is List) {
        print("map['data'] is List");
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': map['data']
              .map<ProductModel>((item) => ProductModel.fromJson(item))
              .toList(),
        };
      }
      throw 'Invalid response format';
    };
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<Response> getProducts({ProductFilter? filter}) async {
    print("filter products: ${filter!.toJson()}");
    return await get('product', query: {
      'per_page': filter.perPage,
      'category': filter.category,
      'store_id': filter.storeId,
      'search': filter.search!.value,
      // 'prices': filter.prices != null ? filter.prices!.join(',') : null,
      'store': filter.store.toString() == 'true' ? 'true' : 'false',
    });
  }

  Future<Response> getProduct(String id) async {
    return await get('product/$id', query: {
      'store': 'true',
    });
  }

  Future<Response> createProduct(
      {required ProductModel product, File? image}) async {
    if (image != null) {
      final formData = FormData({
        'name': product.name,
        'price': product.price,
        'stock': product.stock,
        'category': product.category,
        'description': product.description,
        'image_product':
            MultipartFile(image, filename: image.path.split('/').last),
      });
      return await post('product', formData);
    } else {
      return await post('product', product.toForm());
    }
  }

  Future<Response> updateProduct(
      {required ProductModel product, File? image}) async {
    if (image != null) {
      final formData = FormData({
        'name': product.name,
        'price': product.price,
        'stock': product.stock,
        'category': product.category,
        'description': product.description,
        'image': MultipartFile(image, filename: image.path.split('/').last),
      });
      return await put('product/${product.id}', formData);
    } else {
      return await put('product/${product.id}', product.toForm());
    }
  }

  Future<Response> deleteProduct(int id) async {
    return await delete('product/$id');
  }
}
