import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class RegionProvider extends GetConnect {
  final apiService = Get.find<ApiService>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpClient.baseUrl = apiService.baseUrl;
    httpClient.addAuthenticator<dynamic>((request) {
      request.headers['Authorization'] =
          'Bearer ${LocalStorage.getUser()!['token']}';
      return request;
    });
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
    httpClient.addResponseModifier<dynamic>((request, response) {
      if (response.statusCode == 401) {
        Get.offAllNamed('/login');
      }
      return response;
    });
  }

  Future<Response<dynamic>> getRegions() async {
    return await get('regions');
  }

  Future<Response> getProvince() async {
    try {
      final response = await get(
        'province',
        decoder: (body) {
          final provinces =
              body['data'].map<Province>((e) => Province.fromJson(e)).toList();
          return provinces.toSet().toList(); // Use a set to remove duplicates
        },
      );
      return response;
    } catch (e) {
      // Handle API call failure here
      rethrow;
    }
  }

  //get regency
  Future<Response> getRegency(String provinceId) async {
    return await get('regency', query: {
      'province_id': provinceId,
    }, decoder: (body) {
      return body['data'].map<Regency>((e) => Regency.fromJson(e)).toList();
    });
  }

  //get district
  Future<Response> getDistrict(String regencyId) async {
    return await get('district', query: {
      'regency_id': regencyId,
    }, decoder: (body) {
      return body['data'].map<District>((e) => District.fromJson(e)).toList();
    });
  }

  //get village
  Future<Response> getVillage(String districtId) async {
    return await get(
      'village',
      query: {
        'district_id': districtId,
      },
      decoder: (body) {
        return body['data'].map<Village>((e) => Village.fromJson(e)).toList();
      },
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
