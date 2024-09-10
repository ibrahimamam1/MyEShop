import 'package:e_shop/common/widgets/icons/circular_icon.dart';
import 'package:e_shop/features/shop/controller/products/cart_controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class AppBottomAddToCart extends StatelessWidget {
  const AppBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultSpace,
          vertical: AppSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? AppColors.darkerGrey : AppColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSizes.cardRadiusLg),
            topRight: Radius.circular(AppSizes.cardRadiusLg),
          )),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Row(
                children: [
                  AppCircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: AppColors.darkGrey,
                    width: 40,
                    height: 40,
                    color: AppColors.white,
                    onPressed: () => controller.productQuantityInCart.value < 1
                        ? null
                        : controller.productQuantityInCart.value -= 1,
                  ),
                  const SizedBox(
                    width: AppSizes.spaceBtwItems,
                  ),
                  Text(
                    controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: AppSizes.spaceBtwItems,
                  ),
                  const SizedBox(
                    width: AppSizes.spaceBtwItems,
                  ),
                  AppCircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: AppColors.black,
                    width: 40,
                    height: 40,
                    color: AppColors.white,
                    onPressed: () =>
                        controller.productQuantityInCart.value += 1,
                  ),
                  const SizedBox(
                    width: AppSizes.spaceBtwItems,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(AppSizes.md),
                backgroundColor: AppColors.black,
                side: const BorderSide(color: AppColors.black),
              ),
              child: const Text('Add to cart'),
            )
          ],
        ),
      ),
    );
  }
}
