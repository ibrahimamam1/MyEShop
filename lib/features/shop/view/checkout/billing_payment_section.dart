import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppBillingPaymentSection extends StatelessWidget {
  const AppBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        AppSectionHeading(
          title: 'Payment method',
          buttonTittle: 'Change',
          showActionButton: true,
          onPressed: () {},
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          children: [
            AppCircularContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? AppColors.light : AppColors.white,
              padding: const EdgeInsets.all(AppSizes.sm),
              child: const Image(
                image: AssetImage(AppImages.paypal),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwItems / 2),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge),
          ],
        )
      ],
    );
  }
}
