import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class AddressProvider extends GetConnect {
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<Response> getAddress() async {
    return await get(
      'user/address',
      decoder: (body) {
        print("default decoder address: $body");
        if (body is Map<String, dynamic>) {
          if (body['data'] == null) {
            return <AddressModel>[];
          }
          return body['data']
              .map<AddressModel>((e) => AddressModel.fromJson(e))
              .toList();
        } else {
          return body;
        }
      },
    );
  }

  Future<Response> addAddress({AddressModel? address}) async {
    return await post(
      'user/address',
      address!.toForm(),
      decoder: (body) {
        if (body is Map<String, dynamic>) {
          return AddressModel.fromJson(body['data']);
        } else {
          return body;
        }
      },
    );
  }

  Future<Response> updateAddress({AddressModel? address}) async {
    return await put(
      'user/address/${address!.id}',
      address.toForm(),
      decoder: (body) {
        if (body is Map<String, dynamic>) {
          return AddressModel.fromJson(body['data']);
        } else {
          return body;
        }
      },
    );
  }

  //delete address
  Future<Response> deleteAddress(int id) async {
    return await delete(
      'user/address/$id',
      decoder: (body) {
        if (body is Map<String, dynamic>) {
          return AddressModel.fromJson(body['data']);
        } else {
          return body;
        }
      },
    );
  }
}
