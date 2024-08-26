import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/products/cart/product_quantity_with_add_and_remove_buttons.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_price.dart';
import 'package:e_shop/features/shop/view/cart/widgets/cart_item.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class cartScreen extends StatelessWidget {
  const cartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: SAppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) =>
              const SizedBox(height: AppSizes.spaceBtwSections),
          itemCount: 4,
          itemBuilder: (_, index) => const Column(
            children: [
              AppCartItem(),
              SizedBox(height: AppSizes.spaceBtwItems),
              Row(
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child:
            ElevatedButton(onPressed: () {}, child: const Text('Checkout \$256.8')),
      ),
    );
  }
}
