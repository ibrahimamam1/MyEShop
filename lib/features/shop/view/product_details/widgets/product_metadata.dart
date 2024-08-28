import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/images/app_circular_image.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_price.dart';
import 'package:e_shop/common/widgets/text/brand_title_text_with_verification_icon.dart';
import 'package:e_shop/common/widgets/text/product_title_text.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/enums.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppProductMetaData extends StatelessWidget {
  const AppProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AppHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Price and Sale Price
        Row(
          children: [
            //sale tag
            AppCircularContainer(
              radius: AppSizes.sm,
              backgroundColor: AppColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.sm, vertical: AppSizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: AppColors.black),
              ),
            ),
            const SizedBox(
              width: AppSizes.spaceBtwItems,
            ),
            //price
            Text(
              '\$250',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: AppSizes.spaceBtwItems,
            ),
            const AppProductPrice(
              price: '150',
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems / 1.5,
        ),

        //Title
        const AppProductTitleText(title: 'Green Nike Sports Shirt'),
        const SizedBox(
          height: AppSizes.spaceBtwItems / 1.5,
        ),

        //Stock Status
        Row(
          children: [
            const AppProductTitleText(title: 'Status'),
            const SizedBox(
              width: AppSizes.spaceBtwItems,
            ),
            Text(
              'In Stock',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(
          height: AppSizes.spaceBtwItems / 1.5,
        ),

        //Brand
        Row(
          children: [
            AppCircularImage(
              image: AppImages.cosmeticsIcon,
              width: 32,
              height: 32,
              overlayColor: darkMode ? AppColors.white : AppColors.black,
            ),
            const AppBrandTitleTextWithVerifiedIcon(
              title: 'Nike',
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
