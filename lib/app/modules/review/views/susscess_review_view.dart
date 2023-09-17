import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/routes/app_pages.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SuccessReviewView extends GetView {
  const SuccessReviewView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RoundedContainer(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedContainer(
                width: 80,
                height: 80,
                radius: 40,
                color: ThemeApp.successColor.withOpacity(0.2),
                child: Icon(
                  MdiIcons.checkCircleOutline,
                  size: 50,
                  color: ThemeApp.successColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ulasan Terkirim',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Terima kasih atas ulasannya yang berharga. Kami selalu berupaya memberikan layanan terbaik untuk Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              XButton(
                hasBorder: true,
                color: Colors.white,
                textColor: ThemeApp.neutralColor,
                borderColor: ThemeApp.successColor,
                text: 'Kembali ke Beranda',
                onPressed: () {
                  Get.offAllNamed(
                    Routes.CORE,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
