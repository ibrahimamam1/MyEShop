import 'package:e_shop/features/shop/controller/products/cart_controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/features/shop/view/product_details/product_details.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAddTocartButton extends StatelessWidget {
  const ProductAddTocartButton({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        if (product.productType == 'Single') {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);
        return Container(
          decoration: BoxDecoration(
              color: productQuantityInCart > 0
                  ? AppColors.primary
                  : AppColors.dark,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.cardRadiusMd),
                  bottomRight: Radius.circular(AppSizes.productImageRadius))),
          child: SizedBox(
            width: AppSizes.iconLg * 1.2,
            height: AppSizes.iconLg * 1.2,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(productQuantityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: AppColors.white))
                  : const Icon(
                      Iconsax.add,
                      color: AppColors.white,
                    ),
            ),
          ),
        );
      }),
    );
  }
}
