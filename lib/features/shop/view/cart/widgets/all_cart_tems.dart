import 'package:e_shop/common/widgets/products/cart/product_quantity_with_add_and_remove_buttons.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_price.dart';
import 'package:e_shop/features/shop/controller/products/cart_controller.dart';
import 'package:e_shop/features/shop/view/cart/widgets/cart_item.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppAllCartItems extends StatelessWidget {
  const AppAllCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) =>
            const SizedBox(height: AppSizes.spaceBtwSections),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];

          return Column(
            children: [
              //A Cart Item
              AppCartItem(item: item),
              if (showAddRemoveButtons)
                const SizedBox(height: AppSizes.spaceBtwItems),

              //Add And Remove Buttons with Total Price
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        //Add &  Remove Buttons
                        AppProductQuantityWithAddAndRemoveButtons(
                            quantity: item.quantity,
                            add: () => cartController.addOneToCart(item),
                            remove: () =>
                                cartController.removeOneFromCart(item))
                      ],
                    ),
                    AppProductPrice(
                        price: (item.price * item.quantity).toStringAsFixed(1))
                  ],
                )
            ],
          );
        }),
      ),
    );
  }
}
