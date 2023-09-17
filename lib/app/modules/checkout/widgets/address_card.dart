import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/address_model.dart';
import 'package:refilin_mobile/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardAddress extends StatelessWidget {
  CardAddress({
    super.key,
    required this.address,
    required this.onSelected,
    this.onDelete,
    this.isSelected,
  });

  final AddressModel address;
  final Function(AddressModel) onSelected;
  // final Function(AddressModel) onEdit;
  final Function(AddressModel)? onDelete;
  RxBool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              // Get.toNamed(
              //   Routes.CREATE_ADDRESS,
              //   arguments: address,
              // );
            },
            icon: MdiIcons.pencil,
            foregroundColor: ThemeApp.primaryColor,
            label: "Edit",
          ),
          SlidableAction(
            onPressed: (context) {
              Utils.confirmDialog(
                title: "Hapus Alamat",
                message: "Apakah anda yakin ingin menghapus alamat ini?",
                onConfirm: () {
                  // controller.deleteAddress(address.id!);
                  onDelete!(address);
                },
              );
            },
            icon: MdiIcons.trashCan,
            foregroundColor: ThemeApp.dangerColor,
            label: "Hapus",
          ),
        ],
      ),
      child: RoundedContainer(
        hasBorder: true,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address.contactName!,
                  style: TextStyle(
                    fontSize: 14,
                    color: ThemeApp.darkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Obx(() {
                  return Radio(
                    value: isSelected!.value,
                    groupValue: true,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      onSelected(address);
                    },
                  );
                }),
              ],
            ),
            Row(
              children: [
                Icon(
                  MdiIcons.phone,
                  color: ThemeApp.darkColor,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  address.contactPhone!,
                  style: TextStyle(
                    fontSize: 12,
                    color: ThemeApp.darkColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              address.address!,
              style: TextStyle(
                fontSize: 12,
                color: ThemeApp.darkColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              address.region,
              style: TextStyle(
                fontSize: 12,
                color: ThemeApp.darkColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: address.isDefault!.value == 1,
              child: RoundedContainer(
                padding: const EdgeInsets.all(5),
                radius: 5,
                color: ThemeApp.primaryColor.withOpacity(0.5),
                child: Text(
                  "Alamat Utama",
                  style: TextStyle(
                    fontSize: 10,
                    color: ThemeApp.darkColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
