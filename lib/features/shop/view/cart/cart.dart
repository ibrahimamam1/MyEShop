import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/features/shop/view/cart/widgets/all_cart_tems.dart';
import 'package:e_shop/features/shop/view/checkout/checkout.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: const Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: AppAllCartItems(),
      ),

      //CheckOut Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckOutScreen()),
            child: const Text('Checkout \$256.8')),
      ),
    );
  }
}
