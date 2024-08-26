import 'package:e_shop/features/shop/view/cart/cart.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppCartCounterIcon extends StatelessWidget {
  const AppCartCounterIcon({
    super.key,
    this.iconColor = AppColors.white,
  });

  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => const cartScreen()),
            icon: Icon(Iconsax.shopping_bag, color: iconColor)),
        Positioned(
            right: 0,
            child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: AppColors.white,
                          fontSizeFactor: 0.8,
                        ),
                  ),
                )))
      ],
    );
  }
}
