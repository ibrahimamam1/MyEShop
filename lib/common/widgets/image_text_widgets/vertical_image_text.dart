import 'package:e_shop/common/widgets/images/app_circular_image.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppVerticalImageText extends StatelessWidget {
  const AppVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = AppColors.white,
    this.backgroundcolor = AppColors.white,
    this.isNetworkImage = true,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundcolor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSizes.spaceBtwItems),
        child: Column(
          children: [
            //circular Icon
            AppCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: AppSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundcolor,
              overlayColor: AppHelperFunctions.isDarkMode(context)
                  ? AppColors.light
                  : AppColors.dark,
            ),
            const SizedBox(
              height: AppSizes.spaceBtwItems / 2,
            ),

            //Text
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
