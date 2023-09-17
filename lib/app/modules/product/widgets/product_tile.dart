import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/product_model.dart';
import 'package:refilin_mobile/app/modules/product/bindings/product_binding.dart';
import 'package:refilin_mobile/app/modules/product/views/product_update_view.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class ProductTile extends GetView {
  VoidCallback? onDelete;
  ProductModel product;
  ProductTile({
    super.key,
    required this.product,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      key: Key(product.id.toString()),
      useTextDirection: true,
      groupTag: "product",
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Get.to(
                () => const ProductUpdateView(),
                binding: ProductBinding(),
                arguments: product,
              );
            },
            backgroundColor: ThemeApp.accentColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Edit",
          ),
          SlidableAction(
            onPressed: (context) {
              Utils.confirmDialog(
                title: "Hapus Produk",
                message: "Apakah kamu yakin ingin menghapus ${product.name}?",
                onConfirm: () {
                  Get.back();
                  onDelete!();
                },
              );
            },
            backgroundColor: ThemeApp.dangerColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Hapus",
          ),
        ],
      ),
      child: RoundedContainer(
        hasBorder: true,
        child: ListTile(
          leading: XPicture(
            imageUrl: product.image!,
            size: 50,
          ),
          title: Text(
            product.name!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            product.priceFormatted,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: RoundedContainer(
              //stock
              width: 50,
              height: 30,
              padding: const EdgeInsets.all(5),
              color: int.parse(product.stock!) > 0
                  ? ThemeApp.successColor.withOpacity(0.5)
                  : Colors.red,
              child: Center(
                child: Text(
                  product.stock.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
