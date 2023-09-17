import 'package:flutter/material.dart';

import '../../../common/shape/rounded_container.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(right: 10),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.ac_unit,
          ),
          SizedBox(height: 10),
          Text(
            "Kategori",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
