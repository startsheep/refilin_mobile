import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/order_modell.dart';
import 'package:refilin_mobile/app/models/store_order_model.dart';
import 'package:refilin_mobile/app/models/user_order_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class OrderProvider extends GetConnect {
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
      return response;
    });
  }

//create order
  Future<Response> createOrder({OrderModel? order}) async {
    return await post(
      'order',
      order!.forCreate(),
    );
  }

  Future<Response> myOrder({
    OrderStatus? status,
  }) {
    Map<String, dynamic> query = {};
    if (status!.index == 5) {
      query = {};
    } else {
      query['status'] = status.index.toString();
    }
    return get(
      'order',
      query: query,
      decoder: (body) {
        if (body['status'] == "SUCCESS") {
          return body['data'].map<UserOrderModel>((item) {
            return UserOrderModel.fromJson(item);
          }).toList();
        } else {
          return <UserOrderModel>[];
        }
      },
    );
  }

  Future<Response> updateOrder(Map<String, dynamic> data, String id) async {
    return await put('/orders/$id', data);
  }

  //get order
  Future<Response> getOrder(String id) async {
    return await get('/orders/$id');
  }

  Future<Response> orderInStore({
    OrderStatus? status,
  }) async {
    Map<String, dynamic> query = {};
    if (status!.index == 5) {
      query = {};
    } else {
      query['status'] = status.index.toString();
    }
    return await get(
      'order-store',
      query: query,
      decoder: (body) {
        print("body order store: $body");
        if (body['status'] == "SUCCESS") {
          return body['data'].map<StoreOrderModel>((item) {
            return StoreOrderModel.fromJson(item);
          }).toList();
        } else {
          return <StoreOrderModel>[];
        }
      },
    );
  }
}
