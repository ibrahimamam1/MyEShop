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
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundcolor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSizes.spaceBtwItems),
        child: Column(
          children: [
            //circular Icon
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(AppSizes.sm),
              decoration: BoxDecoration(
                color: backgroundcolor ??
                    (AppHelperFunctions.isDarkMode(context)
                        ? AppColors.black
                        : AppColors.white),
                borderRadius: BorderRadius.circular(180),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  color: AppHelperFunctions.isDarkMode(context)
                      ? AppColors.white
                      : AppColors.dark,
                ),
              ),
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
