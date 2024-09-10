import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/loaders/animation-loader.dart';
import 'package:e_shop/features/shop/controller/products/cart_controller.dart';
import 'package:e_shop/features/shop/view/cart/widgets/all_cart_tems.dart';
import 'package:e_shop/features/shop/view/checkout/checkout.dart';
import 'package:e_shop/navigation_menu.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cartScreen extends StatelessWidget {
  const cartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: SAppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Obx(
        () {
          //nothing found widget
          final emptyWidget = AppAnimationLoaderWidget(
              text: 'Cart is Empty',
              animation: AppImages.cartAnimation,
              showAction: true,
              actionText: 'Add items to your Cart',
              onActionPressed: () => Get.off(() => const NavigationMenu()));

          return controller.cartItems.isEmpty
              ? emptyWidget
              : const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.defaultSpace),
                    child: AppAllCartItems(),
                  ),
                );
        },
      ),

      //CheckOut Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckOutScreen()),
                  child: Obx(() =>
                      Text('Checkout \$${controller.totalCartPrice.value}'))),
            ),
    );
  }
}
