import 'package:get/get.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/providers/address_provider.dart';
import 'package:refilin_mobile/app/services/sql_lite_service.dart';

class OrderAddressController extends GetxController
    with StateMixin<List<AddressModel>> {
  final sqfliteService = Get.find<SqlLiteService>();
  Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);
  final addressProvider = Get.find<AddressProvider>();

  RxList<AddressModel> addresses = <AddressModel>[].obs;

// Fetch all addresses from SQLite

  Future<void> getAddress() async {
    try {
      final res = await addressProvider.getAddress();
      print("response address: ${res.statusCode}");
      if (res.statusCode == 200) {
        final List<AddressModel> responseBody = res.body;

        if (responseBody.isEmpty) {
          change(<AddressModel>[], status: RxStatus.empty());
          return;
        } else {
          addresses.assignAll(responseBody);
          final defaultAddress = addresses.firstWhere(
            (address) => address.isDefault!.value == 1,
            orElse: () => null!,
          );
          selectedAddress.value = defaultAddress;
          change(addresses, status: RxStatus.success());
        }
      } else {
        change([], status: RxStatus.error("Failed to fetch addresses"));
      }
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAddress();
  }

  void deleteAddress(int id) async {
    try {
      // Start loading state
      change([], status: RxStatus.loading());

      // Delete the address from the database
      addressProvider.deleteAddress(id);
      Get.back();
      // Fetch all addresses again
    } catch (e) {
      // If there's an error, update the state with the error
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void selectAddress(AddressModel address) {
    selectedAddress.value = address;
  }
}
