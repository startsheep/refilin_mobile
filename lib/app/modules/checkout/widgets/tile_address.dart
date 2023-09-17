import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/modules/checkout/views/order_address_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TileAddress extends StatelessWidget {
  AddressModel address;
  TileAddress({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      hasBorder: true,
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.all(0),
        leading: const Icon(
          MdiIcons.mapMarker,
          size: 20,
        ),
        title: Text.rich(
          TextSpan(
            text: 'Alamat Pengiriman',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: ' (${address.contactPhone})',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        subtitle: Text(
          address.region,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: InkWell(
          onTap: () {
            Get.to(() => const OrderAddressView());
          },
          child: const Icon(
            MdiIcons.chevronRight,
            size: 20,
          ),
        ),
      ),
    );
  }
}
