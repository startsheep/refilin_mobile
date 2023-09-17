import 'package:flutter/material.dart';
import 'package:refilin_mobile/app/common/buttons/x_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/models/store_model.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreInfoWidget extends StatelessWidget {
  final StoreModel store;

  const StoreInfoWidget({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          horizontalTitleGap: 15,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          leading: XPicture(
            imageUrl: store.logo!,
            size: 40,
          ),
          title: Text(
            store.name!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text.rich(
            TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    MdiIcons.mapMarker,
                    size: 14,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: store.address!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          trailing: XButton(
            icon: MdiIcons.storeOutline,
            color: ThemeApp.secondaryColor,
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 5),
            height: 30,
            onPressed: () {},
            text: "Kunjungi",
            sizeText: 10,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RoundedContainer(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  "20 Produk",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              color: Color.fromARGB(255, 17, 17, 17),
              thickness: 1,
            ),
            Expanded(
              child: RoundedContainer(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "20 Penjualan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
