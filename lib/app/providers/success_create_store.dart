import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_outline_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/routes/app_pages.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreCreationSuccessPage extends StatelessWidget {
  const StoreCreationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedContainer(
                width: 100,
                height: 100,
                radiusType: RadiusType.circle,
                color: ThemeApp.successColor.withOpacity(0.2),
                hasBorder: true,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Icon(
                    MdiIcons.check,
                    color: ThemeApp.successColor,
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Selamat!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ThemeApp.successColor,
                ),
              ),
              const SizedBox(height: 24),
              RoundedContainer(
                padding: const EdgeInsets.all(10),
                hasBorder: true,
                color: ThemeApp.lightColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Toko Anda telah berhasil dibuat',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ThemeApp.successColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Kami dengan senang hati memberitahu Anda bahwa toko Anda telah berhasil dibuat. Mulai sekarang, Anda dapat mengelola toko Anda, mengunggah produk, dan berinteraksi dengan pelanggan Anda.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeApp.darkColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Kami berharap toko Anda menjadi sukses dan memberikan pengalaman belanja yang menyenangkan bagi pelanggan. Jika Anda memiliki pertanyaan atau bantuan, jangan ragu untuk menghubungi tim dukungan kami.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeApp.darkColor,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 24),
              // XButton(
              //   text: 'Kelola Toko',
              //   onPressed: () {
              //     // Utils.launchURL('https://ladangsantara.com');
              //     Get.off(() => const ManageStoreView(),
              //         binding: StoreBinding());
              //   },
              // ),
              const SizedBox(height: 24),
              XOutlineButton(
                text: 'Kembali ke Beranda',
                onPressed: () {
                  // Utils.launchURL('https://ladangsantara.com');
                  Get.offAllNamed(Routes.CORE);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
