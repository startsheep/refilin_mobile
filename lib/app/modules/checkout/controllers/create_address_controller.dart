import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/modules/checkout/controllers/order_address_controller.dart';
import 'package:refilin_mobile/app/providers/address_provider.dart';
import 'package:refilin_mobile/app/providers/region_provider.dart';

class CreateAddressController extends GetxController {
  final regionProvider = Get.find<RegionProvider>();
  final AddressProvider addressProvider = Get.find<AddressProvider>();
  final OrderAddressController orderAddressController =
      Get.find<OrderAddressController>();
  final formKey = GlobalKey<FormState>();
  RxList<Province> provinces = <Province>[].obs;
  RxList<Regency> regencies = <Regency>[].obs;
  RxList<District> districts = <District>[].obs;
  RxList<Village> villages = <Village>[].obs;
  Rx<Province> province = Province().obs;
  Rx<Regency> regency = Regency().obs;
  Rx<District> district = District().obs;
  Rx<Village> village = Village().obs;
  Rx<AddressModel> address = AddressModel(
    isDefault: 0.obs,
  ).obs;
  RxList<AddressModel> listAddress = <AddressModel>[].obs;
  Future<void> getProvinces() async {
    try {
      final res = await regionProvider.getProvince();
      if (res.statusCode == 200) {
        provinces.assignAll(res.body);
      } else {
        throw Exception('Failed to fetch provinces');
      }
    } catch (e) {
      throw Exception('Failed to fetch provinces from API ${e.toString()}}');
    }
  }

  Future<void> getRegency(int id) async {
    try {
      final res = await regionProvider.getRegency(id.toString());
      if (res.statusCode == 200) {
        regencies.assignAll(res.body);
        districts.clear(); // Clear districts when changing regency
        villages.clear(); // Clear villages when changing regency
      } else {
        throw Exception('Failed to fetch regencies');
      }
    } catch (e) {
      throw Exception('Failed to fetch regencies');
    }
  }

  Future<void> getDistrict(int id) async {
    try {
      final res = await regionProvider.getDistrict(id.toString());
      if (res.statusCode == 200) {
        districts.assignAll(res.body);
        villages.clear(); // Clear villages when changing district
      } else {
        throw Exception('Failed to fetch districts');
      }
    } catch (e) {
      throw Exception('Failed to fetch districts');
    }
  }

  Future<void> getVillage(int id) async {
    try {
      final res = await regionProvider.getVillage(id.toString());
      if (res.statusCode == 200) {
        villages.assignAll(res.body);
      } else {
        throw Exception('Failed to fetch villages');
      }
    } catch (e) {
      throw Exception('Failed to fetch villages');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProvinces();
  }

  Future<void> saveAddress() async {
    mappingAddress();
    await addressProvider.addAddress(address: address.value).then((res) {
      if (res.statusCode == 200) {
        Get.back();
        Utils.snackMessage(
          title: "",
          messages: "Berhasil menambahkan alamat",
          type: "success",
        );
        orderAddressController.getAddress();
      }
    }).catchError((e) {
      print("error: $e");
    });
  }

  void mappingAddress() {
    address.update((val) {
      val!.province = province.value;
      val.regency = regency.value;
      val.district = district.value;
      val.village = village.value;
      val.contactName = address.value.contactName;
      val.contactPhone = address.value.contactPhone;
      val.address = address.value.address;
      val.isDefault = address.value.isDefault;
    });
  }
}
