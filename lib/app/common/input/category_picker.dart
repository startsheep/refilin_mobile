import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CategoryPicker extends GetView<CategoryPickerController> {
  final Function(String) onSelected;
  final String? initialValue;
  const CategoryPicker({
    super.key,
    required this.onSelected,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    initialValue != null
        ? controller.selectedCategory.value = initialValue!
        : controller.selectedCategory.value = "";
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(controller.CategoryList.length, (index) {
          bool isSelected = controller.selectedCategory.value ==
              controller.CategoryList[index].name;
          return _buildBadge(controller.CategoryList[index], isSelected);
        }),
      );
    });
  }

  Widget _buildBadge(CategoryModel categoryModel, bool isSelected) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.selectedCategory.value = categoryModel.name!;
          onSelected(controller.selectedCategory.value);
        },
        child: RoundedContainer(
          padding: EdgeInsets.all(isSelected ? 10 : 5),
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          hasBorder: true,
          color: isSelected ? ThemeApp.primaryColor : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                categoryModel.icon,
                color: isSelected ? Colors.white : ThemeApp.neutralColor,
              ),
              const SizedBox(width: 10),
              Text(
                categoryModel.name!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : ThemeApp.neutralColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryPickerController extends GetxController {
  RxList<CategoryModel> CategoryList = <CategoryModel>[
    CategoryModel(
      id: "1",
      name: "Buah",
      icon: MdiIcons.fruitCherries,
    ),
    CategoryModel(
      id: "2",
      name: "Sayur",
      icon: MdiIcons.leaf,
    )
  ].obs;

  RxString selectedCategory = "".obs;
  RxBool selected = false.obs;
}

class CategoryModel {
  final String? id;
  final String? name;
  final IconData? icon;
  CategoryModel({
    this.id,
    this.name,
    this.icon,
  });
}
