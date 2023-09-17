import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/buttons/x_outline_button.dart';
import 'package:refilin_mobile/app/common/input/x_field.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/routes/app_pages.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ThemeApp.refilinPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 230,
                          width: 230,
                          child: SvgPicture.asset(
                            "assets/logo/logo_transparent_white.svg",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Selamat Datang ",
                            style: TextStyle(
                              color: ThemeApp.backgroundColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: "Di Refilin",
                                style: GoogleFonts.poppins(
                                  color: ThemeApp.ifGradientColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Masuk ke akun anda",
                    style: TextStyle(
                      color: ThemeApp.backgroundColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  XTextField(
                    labelText: "Email",
                    hintText: "ahmad@xample.com",
                    prefixIcon: MdiIcons.emailOutline,
                    initialValue: controller.user.value.email,
                    onSave: (val) {
                      // controller.phone.value = val!;
                      controller.user.value.email = val!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email harus di isi";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () {
                      return XTextField(
                        labelText: "Kata sandi",
                        hintText: "pass****123",
                        prefixIcon: MdiIcons.lockOutline,
                        initialValue: controller.user.value.password,
                        onSave: (val) {
                          // controller.password.value = val!;
                          controller.user.value.password = val!;
                        },
                        suffixIcon: controller.isShowPass.value
                            ? MdiIcons.eyeOutline
                            : MdiIcons.eyeOffOutline,
                        obscureText: !controller.isShowPass.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "sandi harus di isi";
                          }
                          if (value.length < 8) {
                            return "minimal 8 karakter";
                          }
                          return null;
                        },
                        onPressSuffix: () {
                          controller.isShowPass.value =
                              !controller.isShowPass.value;
                        },
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: ThemeApp.backgroundColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    return controller.isLoading.value
                        ? Center(
                            child: Utils.loadingWidget(size: 30),
                          )
                        : XButton(
                            text: "Masuk",
                            hasIcon: true,
                            icon: MdiIcons.login,
                            color: ThemeApp.ifGradientColor,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                controller.login();
                              }
                            },
                          );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: ThemeApp.backgroundColor,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Atau",
                        style: TextStyle(
                          color: ThemeApp.backgroundColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(
                          color: ThemeApp.backgroundColor,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // register
                  XOutlineButton(
                    text: "Mendaftar",
                    textColor: ThemeApp.backgroundColor,
                    hasIcon: true,
                    icon: MdiIcons.accountPlusOutline,
                    iconColor: ThemeApp.backgroundColor,
                    borderColor: ThemeApp.backgroundColor,
                    onPressed: () {
                      // controller.register();
                      Get.toNamed(
                        Routes.REGISTER,
                        preventDuplicates: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
