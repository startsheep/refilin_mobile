import 'package:get/get.dart';
import 'package:refilin_mobile/app/services/api_service.dart';

class GoogleMapsProvider extends GetConnect {
  String _apiKey = '';
  String _baseUrl = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _apiKey = ApiService().apiKey!;
    _baseUrl = ApiService().baseUrlGoogleMaps!;
  }

  Future<Response> getDistance({
    required String origin,
    required String destination,
  }) async {
    final response = await get(
      '$_baseUrl?origin=$origin&destination=$destination&key=$_apiKey',
    );
    return response;
  }
}
