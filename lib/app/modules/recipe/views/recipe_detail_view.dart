import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/buttons/x_Icon_button.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RecipeDetailView extends GetView {
  const RecipeDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: RoundedContainer(
        height: Get.height,
        child: Stack(
          children: [
            XPicture(
              imageUrl: "",
              assetImage: "assets/images/sample-recipe.jpeg",
              sizeHeight: 400,
              sizeWidth: Get.width,
            ),
            Positioned(
              top: 0,
              child: RoundedContainer(
                padding: const EdgeInsets.all(10),
                width: Get.width,
                color: Colors.transparent,
                child: Row(
                  children: [
                    XIconButton(
                        icon: MdiIcons.chevronLeft, onTap: () => Get.back()),
                    const Spacer(),
                    XIconButton(icon: MdiIcons.shareVariant, onTap: () {}),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: RoundedContainer(
                key: const Key("recipe_detail"),
                padding: const EdgeInsets.all(10),
                width: Get.width,
                height: Get.height * 0.6,
                radius: 30,
                radiusType: RadiusType.onlyTop,
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        "Resep Ayam Bakar",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        "khas indonesia",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      trailing: XIconButton(
                        icon: MdiIcons.heartOutline,
                        size: 20,
                        onTap: () {},
                        color: Colors.red,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        children: [
                          RoundedContainer(
                            padding: const EdgeInsets.all(10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Deskripsi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ExpandableText(
                                  "Deskiskj kdsh kdjhskdjhs kfhsdf",
                                  expandText: "Selengkapnya",
                                  collapseText: "Sembunyikan",
                                  maxLines: 3,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          RoundedContainer(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Bahan",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: const XPicture(
                                        imageUrl: "",
                                        assetImage:
                                            "assets/images/placeholder.jpg",
                                        size: 50,
                                        radius: 10,
                                      ),
                                      title: Text(
                                        "Bahan ${index + 1}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      trailing: const Text(
                                        "1 kg",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
