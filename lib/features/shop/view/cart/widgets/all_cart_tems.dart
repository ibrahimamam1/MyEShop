import 'package:e_shop/common/widgets/products/cart/product_quantity_with_add_and_remove_buttons.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_price.dart';
import 'package:e_shop/features/shop/view/cart/widgets/cart_item.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppAllCartItems extends StatelessWidget {
  const AppAllCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSizes.spaceBtwSections),
      itemCount: 4,
      itemBuilder: (_, index) => Column(
        children: [
          //A Cart Item
          const AppCartItem(),
          if (showAddRemoveButtons)
            const SizedBox(height: AppSizes.spaceBtwItems),

          //Add And Remove Buttons with Total Price
          if (showAddRemoveButtons)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 70),
                    //Add &  Remove Buttons
                    AppProductQuantityWithAddAndRemoveButtons()
                  ],
                ),
                AppProductPrice(price: '256')
              ],
            )
        ],
      ),
    );
  }
}
