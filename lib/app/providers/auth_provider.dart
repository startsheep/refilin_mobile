import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/user.dart';
import 'package:refilin_mobile/app/services/api_service.dart';

class AuthProvider extends GetConnect {
  final ApiService apiService = Get.find<ApiService>();
  @override
  void onInit() {
    // httpClient.defaultDecoder = (map) => User.fromJson(map);
    // httpClient.baseUrl = ApiService.baseUrl;
    httpClient.baseUrl = "${apiService.baseUrl!}auth/";
  }

  Future<Response> login({required UserModel user}) async {
    final bodyData = user.toJson();
    return await post(
      'login',
      bodyData,
      decoder: (body) {
        final token = body['token'];
        final user = body['data'];
        if (body['status'] == "SUCCESS") {
          return {
            'status': 'SUCCESS',
            'message': body['message'],
            'data': UserModel.fromJson(user).copyWith(token: token),
          };
        } else {
          return {'status': 'ERROR', 'data': null, 'message': body['message']};
        }
      },
    );
  }

  Future<Response> register({required UserModel? user}) async {
    return await post(
      'register',
      {
        'name': user!.name,
        'email': user.email,
        'password': user.password,
        'retype_password': user.retypedPassword,
      },
      decoder: (body) {
        print(body);
        if (body['status'] == "SUCCESS") {
          return {
            'status': 'SUCCESS',
            'message': body['message'],
            'data': UserModel.fromJson(body['data']),
          };
        } else {
          return {'status': 'ERROR', 'data': null, 'message': body['messages']};
        }
      },
    );
  }

  Future<Response> logout() async {
    return await post(
      '/logout',
      {},
    );
  }
}
