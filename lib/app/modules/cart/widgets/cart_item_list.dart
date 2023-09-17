import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/common/input/increment_decrement.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/models/cart_item_model.dart';
import 'package:refilin_mobile/app/models/cart_model.dart';
import 'package:refilin_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:refilin_mobile/app/themes/theme.dart';

class CartItemListWidget extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final CartModel cart;
  final controller = Get.find<CartController>();
  CartItemListWidget({
    super.key,
    required this.cartItems,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      constraints: const BoxConstraints(
        // minHeight: 100,
        maxHeight: 500,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        shrinkWrap: true,
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return Obx(() {
            return Slidable(
              key: ValueKey(cartItem.id),
              dragStartBehavior: DragStartBehavior.start,
              groupTag: cartItem.id,
              closeOnScroll: true,
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dragDismissible: true,
                dismissible: RoundedContainer(
                  color: Colors.red,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          'Hapus ${cartItem.product!.name!}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DismissiblePane(
                        onDismissed: () {
                          controller.removeItem(cartItem, cart);
                        },
                      ),
                    ],
                  ),
                ),
                children: const [],
              ),
              child: RoundedContainer(
                hasBorder: true,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(5),
                  leading: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Checkbox(
                          value: cartItem.selected!.value,
                          onChanged: (value) {
                            // cartItem.selected!.value = value!;
                            controller.toggleItemSelection(cartItem, cart);
                            controller.update();
                          },
                          // ...
                          side: BorderSide(
                            color: ThemeApp.primaryColor,
                            style: BorderStyle.solid,
                          ),
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.all<Color>(
                              ThemeApp.primaryColor),
                          activeColor: ThemeApp.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        XPicture(
                          imageUrl: cartItem.product!.image!,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    cartItem.product!.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: RoundedContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    color: ThemeApp.primaryColor.withOpacity(0.2),
                    child: Text(
                      cartItem.product!.priceFormatted,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  trailing: IncDecWidget(
                    sizeField: 20,
                    width: 100,
                    onIncTap: () {
                      // controller.incrementQty(cartItem);
                      //
                      controller.increaseQty(cartItem);
                    },
                    onDecTap: () {
                      // controller.decrementQty(cartItem);
                      controller.decreaseQty(cartItem);
                    },
                    onChange: (val) {
                      // controller.updateQty(cartItem, val);
                      // controller.updateQty(cartItem, val);
                    },
                    minValue: 1,
                    maxValue: int.tryParse(cartItem.product!.stock!)!,
                    isDisabled: int.parse(cartItem.qty!) >=
                        int.parse(cartItem.product!.stock!),
                    initialValue: int.parse(cartItem.qty.toString()),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
