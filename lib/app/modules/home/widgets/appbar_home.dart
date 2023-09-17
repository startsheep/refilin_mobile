import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_Icon_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/services/location_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppbarHome extends StatefulWidget {
  const AppbarHome({
    super.key,
  });

  @override
  State<AppbarHome> createState() => _AppbarHomeState();
}

class _AppbarHomeState extends State<AppbarHome> {
  String address = "Lokasi Anda";
  final LocationService locationService = Get.find<LocationService>();

  @override
  void initState() {
    super.initState();
    locationService.getCurrentPosition();
    locationService
        .getAddressFromCoordinates(
      latitude: locationService.latitude.value,
      longitude: locationService.longitude.value,
    )
        .then((value) {
      setState(() {
        address = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      hasBorder: true,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.6,
            child: Row(
              children: [
                XIconButton(
                  icon: MdiIcons.mapMarker,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                  supportColor: Theme.of(context).primaryColor.withOpacity(0.5),
                  onTap: () async {
                    await locationService.getCurrentPosition();
                    locationService
                        .getAddressFromCoordinates(
                      latitude: locationService.latitude.value,
                      longitude: locationService.longitude.value,
                    )
                        .then((value) {
                      setState(() {
                        address = value!;
                      });
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    address,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          RoundedContainer(
            child: const XPicture(
              imageUrl: "",
              size: 40,
              assetImage: "assets/icons/avatar.png",
              radiusType: RadiusType.circle,
            ),
          )
        ],
      ),
    );
  }
}
