import 'package:e_shop/common/styles/shadow_styles.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/images/app_rounded_image.dart';
import 'package:e_shop/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_price.dart';
import 'package:e_shop/common/widgets/text/brand_title_text_with_verification_icon.dart';
import 'package:e_shop/common/widgets/text/product_title_text.dart';
import 'package:e_shop/features/shop/controller/products/product_controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/features/shop/view/product_details/product_details.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppProductCardVertical extends StatelessWidget {
  const AppProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final dark = AppHelperFunctions.isDarkMode(context);
    final discountPercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
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
              width: 180,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  //thumbnail image
                  Center(
                    child: AppRoundedImage(
                      imageURL: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  //sale tag
                  if (discountPercentage != null)
                    Positioned(
                      top: 12,
                      child: AppCircularContainer(
                        radius: AppSizes.sm,
                        backgroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.sm, vertical: AppSizes.xs),
                        child: Text(
                          discountPercentage,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: AppColors.black),
                        ),
                      ),
                    ),

                  //favorite icon button
                  Positioned(
                      top: 0,
                      right: 0,
                      child: AppFavouriteIcon(
                        productId: product.id,
                      ))
                ],
              ),
            ),

            //details
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.sm),
              child: Container(
                decoration: BoxDecoration(
                    color: dark ? AppColors.dark : AppColors.light),
                child: Column(
                  children: [
                    AppProductTitleText(
                      title: product.title,
                      smallSize: true,
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwItems / 2,
                    ),
                    AppBrandTitleTextWithVerifiedIcon(
                        title: product.brand!.name),
                  ],
                ),
              ),
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //price
                Flexible(
                  child: Column(children: [
                    if (product.productType == 'single' &&
                        product.salePrice > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: AppSizes.sm),
                        child: Text(
                          product.price.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: AppSizes.sm),
                      child: AppProductPrice(
                        price: controller.getProductPrice(product),
                      ),
                    ),
                  ]),
                ),

                //Add to Cart Button
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.dark,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(AppSizes.productImageRadius))),
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
      ),
    );
  }
}
