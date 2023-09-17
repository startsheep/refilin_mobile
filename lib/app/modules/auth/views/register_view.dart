import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/input/x_field.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mendaftar"),
        centerTitle: true,
        backgroundColor: ThemeApp.refilinPrimaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // MAKE COPY WRITER FOR REGISTER
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  XTextField(
                    labelText: "Nama",
                    hintText: "Ahmad",
                    prefixIcon: MdiIcons.accountOutline,
                    keyboardType: TextInputType.emailAddress,
                    onSave: (value) {
                      controller.user.value.name = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  XTextField(
                    labelText: "Email",
                    hintText: "ahmad@mail.com",
                    prefixIcon: MdiIcons.accountOutline,
                    keyboardType: TextInputType.emailAddress,
                    onSave: (value) {
                      controller.user.value.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return XTextField(
                      labelText: "Password",
                      hintText: "Masukkan Password",
                      prefixIcon: MdiIcons.lockOutline,
                      obscureText: !controller.isShowPass.value,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: controller.isShowPass.value
                          ? MdiIcons.eyeOutline
                          : MdiIcons.eyeOffOutline,
                      onSave: (value) {
                        // print(value);
                        controller.user.value.password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      onPressSuffix: () {
                        controller.isShowPass.value =
                            !controller.isShowPass.value;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return XTextField(
                      labelText: "Konfirmasi Password",
                      prefixIcon: MdiIcons.lockOutline,
                      hintText: "Masukkan Konfirmasi Password",
                      obscureText: !controller.isShowPassConfirm.value,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: controller.isShowPassConfirm.value
                          ? MdiIcons.eyeOutline
                          : MdiIcons.eyeOffOutline,
                      onSave: (value) {
                        controller.user.value.retypedPassword = value;
                      },
                      validator: (value) {
                        // print(value);
                        print(controller.user.value.password);
                        if (value!.isEmpty) {
                          return "Confirm Password is required";
                        } else if (value != controller.user.value.password) {
                          return "Confirm Password is not match";
                        }
                        return null;
                      },
                      onPressSuffix: () {
                        controller.isShowPassConfirm.value =
                            !controller.isShowPassConfirm.value;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(
                        child: Utils.loadingWidget(size: 30),
                      );
                    }
                    return XButton(
                      color: ThemeApp.refilinPrimaryColor,
                      onPressed: () async {
                        print(controller.user.value.toJson());
                        controller.formKey.currentState!.save();
                        if (controller.formKey.currentState!.validate()) {
                          await controller.register();
                        }
                      },
                      text: "Register Sekarang",
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
