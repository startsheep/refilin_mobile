import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/user.dart';
import 'package:refilin_mobile/app/providers/auth_provider.dart';
import 'package:refilin_mobile/app/routes/app_pages.dart';
import 'package:refilin_mobile/app/services/local_storage_service.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  RxBool isShowPass = false.obs;
  RxBool isShowPassConfirm = false.obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  Rx<UserModel> user = UserModel().obs;
  final authProvide = Get.find<AuthProvider>();
  @override
  void onClose() {}

  Future<void> login() async {
    isLoading.value = true;
    await authProvide.login(user: user.value).then((res) {
      if (res.body['status'] == "SUCCESS") {
        Utils.snackMessage(
            title: "Berhasil", messages: "Berhasil Login", type: "success");
        LocalStorage.setUser = res.body['data'].toJson();
        LocalStorage.setIsUserLoggedIn = true;
        Get.offAllNamed(Routes.CORE);
        user.value = UserModel();
      } else {
        Utils.snackMessage(
          title: "Gagal",
          messages: "Login Gagal",
          type: "error",
        );
      }
    });
    isLoading.value = false;
  }

  Future<void> register() async {
    isLoading.value = true;
    await authProvide.register(user: user.value).then((value) {
      // print("value" + value.body);
      if (value.body['status'] == "SUCCESS") {
        Utils.snackMessage(
            title: "Berhasil", messages: "Berhasil Register", type: "success");
        Get.offAllNamed(Routes.AUTH);
        user.value = UserModel();
      } else {
        Utils.snackMessage(
          title: "Gagal",
          messages: "Register Gagal",
          type: "error",
        );
      }
    });
    isLoading.value = false;
  }
}
