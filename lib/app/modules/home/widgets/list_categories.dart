import 'package:flutter/material.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class ListCategory extends StatelessWidget {
  ListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RoundedContainer(
            gradient: RadialGradient(
              colors: [
                ThemeApp.refilinPrimaryColor.withOpacity(0.1),
                ThemeApp.refilinPrimaryColor.withOpacity(0.1),
                ThemeApp.refilinPrimaryColor.withOpacity(0.3),
                ThemeApp.refilinPrimaryColor.withOpacity(0.5),
              ],
            ),
            hasBorder: true,
            borderColor: Colors.grey[300],
            width: 70,
            height: 65,
            child: Center(
              child: Image.asset(
                'assets/content/${categories[index]['image']}',
                width: 30,
                height: 30,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> categories = [
    {
      'name': 'Body Wash',
      'image': 'soap.png',
    },
    {
      'name': 'Laundry Detergent',
      'image': 'laundry-detergent.png',
    },
    {
      'name': 'Sabun Cuci Piring',
      'image': 'dish-washing.png',
    },
  ];
}
