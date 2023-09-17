import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/x_dividerdotted.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaymentCodeView extends GetView {
  const PaymentCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kode Pembayaran',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          RoundedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          MdiIcons.clockOutline,
                          size: 16,
                        ),
                      ),
                      TextSpan(
                        text: ' Menunggu Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                // Text(
                //   'Total Pembayaran : Rp 10.000',
                //   style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                SizedBox(height: 5),
                //batas waktu countdown
                Text(
                  'Batas Waktu Pembayaran : 00:00:00',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          RoundedContainer(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nomor Virtual Account",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                RoundedContainer(
                  hasBorder: true,
                  radius: 5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: ThemeApp.secondaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "va-3xwe23232342",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const XDividerDotted(
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      InkWell(
                        onTap: () {
                          FlutterClipboard.copy(
                            //copy to clipboard
                            "1234567890",
                          ).then(
                            (value) => Get.snackbar(
                              "Berhasil",
                              "Nomor Virtual Account berhasil disalin",
                              shouldIconPulse: true,
                              backgroundColor: Colors.white,
                              colorText: ThemeApp.darkColor,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              icon: Icon(
                                MdiIcons.checkCircleOutline,
                                color: ThemeApp.successColor,
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //icon
                            Icon(
                              MdiIcons.contentCopy,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Salin",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Ambil tangkapan layar halaman ini atau catat kode pembayaran Anda untuk catatan Anda, Anda dapat menemukan halaman ini di menu ",
                      ),
                      TextSpan(
                        text:
                            "Profile > Pesanan Saya > Kode Pembayaran > Salin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          RoundedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Bank",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icon/bca.png',
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bank BCA",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "a/n PT. Ladang Santara",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          RoundedContainer(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cara Pembayaran",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ExpansionTile(
                  leading: Icon(
                    MdiIcons.creditCardOutline,
                  ),
                  title: Text(
                    "Melalui ATM",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ExpansionTile(
                  leading: Icon(
                    MdiIcons.bankTransfer,
                  ),
                  title: Text(
                    "Melalui Internet Banking",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ExpansionTile(
                  leading: Icon(
                    MdiIcons.cellphone,
                  ),
                  title: Text(
                    "Melalui Mobile Banking",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
