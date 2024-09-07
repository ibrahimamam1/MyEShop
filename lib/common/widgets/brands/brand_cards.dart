import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/images/app_circular_image.dart';
import 'package:e_shop/common/widgets/text/brand_title_text_with_verification_icon.dart';
import 'package:e_shop/features/shop/models/brand_model.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/enums.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppBrandCard extends StatelessWidget {
  const AppBrandCard(
      {super.key, this.onTap, required this.showBorder, required this.brand});

  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: AppCircularContainer(
        padding: const EdgeInsets.all(AppSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Icon
            Flexible(
              child: AppCircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? AppColors.white : AppColors.black,
              ),
            ),
            const SizedBox(
              width: AppSizes.spaceBtwItems / 2,
            ),
            //Text
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBrandTitleTextWithVerifiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${(brand.productsCount ?? 0)} Products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
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
