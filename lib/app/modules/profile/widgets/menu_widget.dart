import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/models/menu_model.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:shimmer/shimmer.dart';

class FeatureWidget extends StatelessWidget {
  MenuModel? menu;
  FeatureWidget({
    super.key,
    this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      hasBorder: true,
      child: ListTile(
        tileColor: Colors.white,
        onTap: () {
          if (menu!.route != null) {
            Get.toNamed(menu!.route!);
          } else {
            menu!.onTap!();
          }
          // Utils.toNamed(menu!.route);
        },
        leading: Icon(
          menu!.icon,
          color: ThemeApp.darkColor.withOpacity(0.5),
        ),
        title: Text(
          menu!.title,
          style: TextStyle(
            fontSize: 16,
            color: ThemeApp.darkColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ThemeApp.darkColor.withOpacity(0.5),
        ),
      ),
    );
  }
}

class FeatureShimmerWidget extends StatelessWidget {
  const FeatureShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: const Color.fromARGB(127, 205, 205, 205),
      child: ListTile(
        tileColor: Colors.white,
        onTap: () {},
        leading: RoundedContainer(
          width: 30,
          height: 30,
          child: Container(
            color: Colors.grey[300],
          ),
        ),
        title: RoundedContainer(
          width: 100,
          height: 14,
          child: Container(
            color: Colors.grey,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
      ),
    );
  }
}
