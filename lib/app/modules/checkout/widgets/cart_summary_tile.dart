import 'package:flutter/material.dart';
import 'package:refilin_mobile/app/common/shape/rounded_container.dart';
import 'package:refilin_mobile/app/common/ui/x_dividerdotted.dart';
import 'package:refilin_mobile/app/common/ui/xpicture.dart';
import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/cart_model.dart';
import 'package:refilin_mobile/app/modules/checkout/widgets/cart_item_tile.dart';
import 'package:refilin_mobile/app/modules/checkout/widgets/delivery_method_widget.dart';

class CartSummaryTile extends StatelessWidget {
  final CartModel cart;

  const CartSummaryTile({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                XPicture(
                  imageUrl: cart.store!.logo!,
                  size: 25,
                  radiusType: RadiusType.circle,
                ),
                const SizedBox(width: 10),
                Text(
                  cart.store!.name!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const XDividerDotted(
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          RoundedContainer(
            constraints: const BoxConstraints(
              maxHeight: 500,
            ),
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: cart.cartItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = cart.cartItems[index];
                return CartItemTile(item: item);
              },
            ),
          ),
          const XDividerDotted(
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          const DeliveryMethodTile(),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${cart.cartItems.length} produk, total',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  cart.total,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
