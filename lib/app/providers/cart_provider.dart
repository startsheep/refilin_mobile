import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/cart_item_model.dart';
import 'package:refilin_mobile/app/models/cart_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class CartProvider extends GetConnect {
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
    httpClient.defaultDecoder = (responseBody) {
      print("default decoder cart: $responseBody");
      final map = responseBody as Map<String, dynamic>;
      // print("default decoder cart: $map");
      if (map['status'] == 'ERROR') {
        throw map['message'];
      }
      if (map['data'] is Map<String, dynamic>) {
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': CartModel.fromJson(map['data']),
        };
      } else if (map['data'] is List) {
        print("map['data'] carts is List");
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': map['data'] != null
              ? map['data']
                  .map<CartModel>((e) => CartModel.fromJson(e).copyWith(
                        selected: false.obs,
                      ))
                  .toList()
              : [],
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

  Future<Response> getCart() async {
    return await get('cart', query: {"product": "true"});
  }

  Future<Response> deleteCart({required String id}) async {
    return await delete(
      'cart/$id',
      decoder: (data) {
        if (data['status'] == 'SUCCESS') {
          return {
            'status': 'SUCCESS',
            'message': data['message'],
            'data': CartItemModel.fromJson(data['data']),
          };
        } else if (data['status'] == 'ERROR') {
          throw data['message'];
        } else {
          throw 'Invalid response format';
        }
      },
    );
  }

  Future<Response> addToCart({
    required String productId,
    qty,
  }) async {
    return await post(
      'cart',
      {
        "product_id": productId,
        "qty": qty,
      },
      decoder: (body) {
        if (body['status'] == 'SUCCESS') {
          return {
            'status': 'SUCCESS',
            'message': body['message'],
            'data': CartItemModel.fromJson(body['data']),
          };
        } else if (body['status'] == 'ERROR') {
          throw body['message'];
        } else {
          throw 'Invalid response format';
        }
      },
    );
  }

  Future<Response> updateCart({
    required String cartId,
    required String qty,
  }) async {
    return await put('cart/$cartId', {
      "qty": qty,
    });
  }

  //addqty
  Future<Response> addQty({required String id}) async {
    return await put(
      'cart/add-qty/$id',
      {},
      decoder: (data) {
        print("addQty: $data");
        if (data['status'] == 'SUCCESS') {
          return {
            'status': 'SUCCESS',
            'message': data['message'],
            'data': CartItemModel.fromJson(data['data']),
          };
        } else if (data['status'] == 'WARNING') {
          return {
            'status': 'WARNING',
            'message': data['messages'],
          };
        }
      },
    );
  }

  Future<Response> reduceQty({required String id}) async {
    return await put(
      'cart/reduce-qty/$id',
      {},
      decoder: (data) {
        if (data['status'] == 'SUCCESS') {
          return {
            'status': 'SUCCESS',
            'message': data['message'],
            'data': CartItemModel.fromJson(data['data']),
          };
        } else if (data['status'] == 'ERROR') {
          throw data['message'];
        } else {
          throw 'Invalid response format';
        }
      },
    );
  }
}
