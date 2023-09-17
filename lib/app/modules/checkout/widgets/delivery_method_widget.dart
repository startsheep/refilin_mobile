import 'package:flutter/material.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DeliveryMethodTile extends StatelessWidget {
  const DeliveryMethodTile({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Standar Pengiriman",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(
                MdiIcons.truckDeliveryOutline,
                size: 15,
              ),
              SizedBox(width: 10),
              Text(
                "Dari Desa Lohbeer",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
