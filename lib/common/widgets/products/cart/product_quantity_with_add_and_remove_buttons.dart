import 'package:e_shop/common/widgets/icons/circular_icon.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppProductQuantityWithAddAndRemoveButtons extends StatelessWidget {
  const AppProductQuantityWithAddAndRemoveButtons({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;
  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: AppSizes.md,
          color: dark ? AppColors.white : AppColors.dark,
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.light,
          onPressed: remove,
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        Text(quantity.toString(),
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: AppSizes.spaceBtwItems),
        AppCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: AppSizes.md,
          color: AppColors.white,
          backgroundColor: AppColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
