import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/recipe_model.dart';
import 'package:refilin_mobile/app/services/api_service.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class RecipeProvider extends GetConnect {
  final apiService = Get.find<ApiService>();
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
    super.onInit();
    httpClient.defaultDecoder = (responseBody) {
      final map = responseBody as Map<String, dynamic>;
      print("default decoder : $map");
      if (map['status'] == 'ERROR') {
        throw map['message'];
      }
      if (map['data'] is Map<String, dynamic>) {
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': RecipeModel.fromJson(map['data']),
        };
      } else if (map['data'] is List) {
        print("map['data'] is List");
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': map['data']
              .map<RecipeModel>((item) => RecipeModel.fromJson(item))
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

  Future<Response> getRecipes({String? search}) async {
    search = search!.split(' ').first;
    print("Search $search");
    return await get(
      'recipe',
      query: {
        'search': search,
      },
    );
  }
}
