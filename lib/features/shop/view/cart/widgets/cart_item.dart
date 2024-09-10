import 'package:e_shop/common/widgets/images/app_rounded_image.dart';
import 'package:e_shop/common/widgets/text/brand_title_text_with_verification_icon.dart';
import 'package:e_shop/common/widgets/text/product_title_text.dart';
import 'package:e_shop/features/shop/models/cart_item_model.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class AppCartItem extends StatelessWidget {
  const AppCartItem({
    super.key,
    required this.item,
  });

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        //Image
        AppRoundedImage(
          isNetworkImage: true,
          imageURL: item.image!,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(AppSizes.sm),
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.light,
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),

        //Title, Price, and Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBrandTitleTextWithVerifiedIcon(title: item.brandName!),
              Flexible(
                child: AppProductTitleText(
                  title: item.title,
                  maxLines: 1,
                ),
              ),

              //Atributes
              Text.rich(TextSpan(
                  children: (item.selectedvariation ?? {})
                      .entries
                      .map((element) => TextSpan(children: [
                            TextSpan(
                                text: element.key,
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: element.value,
                                style: Theme.of(context).textTheme.bodyLarge)
                          ]))
                      .toList()))
            ],
          ),
        )
      ],
    );
  }
}
