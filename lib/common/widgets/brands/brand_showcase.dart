import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/brands/brand_cards.dart';
import 'package:e_shop/features/shop/models/brand_model.dart';
import 'package:e_shop/features/shop/view/brands/brand_product.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBrandShowCase extends StatelessWidget {
  const AppBrandShowCase(
      {super.key, required this.images, required this.brand});

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: AppCircularContainer(
        showBorder: true,
        borderColor: AppColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(AppSizes.md),
        margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: Column(
          children: [
            //Brand with Produc Count
            AppBrandCard(showBorder: false, brand: brand),
            const SizedBox(height: AppSizes.spaceBtwItems),

            //Brand Top3 Products
            Row(
                children: images
                    .map((imageUrl) =>
                        brandTopProductImageWidget(imageUrl, context))
                    .toList()),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Expanded(
      child: AppCircularContainer(
        height: 100,
        backgroundColor: dark ? AppColors.darkerGrey : AppColors.light,
        margin: const EdgeInsets.only(right: AppSizes.sm),
        padding: const EdgeInsets.all(AppSizes.md),
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          //todo : add progress indicator builder , ref : vid48 , t:2117
        ),
      ),
    );
  }
}
