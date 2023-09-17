import 'package:flutter/material.dart';
import 'package:refilin_mobile/app/common/utils.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hintText;
  final Future<List<T>> itemsFuture;
  final T? value;
  final ValueChanged<T?> onChanged;
  final Function(T?)? itemBuilder;

  const CustomDropdown({
    Key? key,
    required this.hintText,
    required this.itemsFuture,
    this.itemBuilder,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Utils.loadingWidget(
              size: 20,
            ),
          ); // Show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else {
          final items = snapshot.data!;
          return DropdownButtonFormField<T>(
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: itemBuilder != null
                    ? itemBuilder!(item)
                    : Text(item.toString()),
              );
            }).toList(),
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            validator: (val) {
              if (val == null) {
                return "Harap pilih $hintText";
              }
              return null;
            },
            onChanged: onChanged,
            // value: value,
          );
        }
      },
    );
  }
}
