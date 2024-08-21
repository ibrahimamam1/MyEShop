import 'package:e_shop/common/styles/shadow_styles.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/icons/circular_icon.dart';
import 'package:e_shop/common/widgets/images/app_rounded_image.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_price.dart';
import 'package:e_shop/common/widgets/text/product_title_text.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppProductCardVertical extends StatelessWidget {
  const AppProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [AppShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
            color: dark ? AppColors.darkGrey : AppColors.white),
        child: Column(
          children: [
            //Thumbnail , wishlist buttpn , discount tag
            AppCircularContainer(
              height: 180,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  //thumbnail image
                  const AppRoundedImage(
                    imageURL: AppImages.productImage1,
                    applyImageRadius: true,
                  ),

                  //sale tag
                  Positioned(
                    top: 12,
                    child: AppCircularContainer(
                      radius: AppSizes.sm,
                      backgroundColor: AppColors.secondary,
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
                  ),

                  //favorite icon button
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: AppCircularIcon(
                      icon: Iconsax.heart,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),

            //details
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.sm),
              child: Column(
                children: [
                  const AppProductTitletext(
                    title: 'Green Nike Air Shoes',
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    children: [
                      Text(
                        'Nike',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        width: AppSizes.xs,
                      ),
                      const Icon(
                        Iconsax.verify,
                        color: AppColors.primary,
                        size: AppSizes.iconXs,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      const AppProductPrice(
                        price: '35',
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.dark,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSizes.cardRadiusMd),
                                bottomRight: Radius.circular(
                                    AppSizes.productImageRadius))),
                        child: const SizedBox(
                          width: AppSizes.iconLg * 1.2,
                          height: AppSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
