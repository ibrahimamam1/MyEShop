import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppOrderListItems extends StatelessWidget {
  const AppOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (_, index) => AppCircularContainer(
        showBorder: true,
        padding: const EdgeInsets.all(AppSizes.sm),
        backgroundColor: dark ? AppColors.dark : AppColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Row 1
            Row(
              children: [
                //1-Icon
                const Icon(Iconsax.ship),
                const SizedBox(width: AppSizes.spaceBtwItems / 2),

                //2-Status abd date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: AppColors.primary, fontWeightDelta: 1),
                      ),
                      Text('02 Sep 2024',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),

                //3- Icon
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.arrow_right_34, size: AppSizes.iconSm)),
              ],
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),
            //Row 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      //1-Icon
                      const Icon(Iconsax.tag),
                      const SizedBox(width: AppSizes.spaceBtwItems / 2),

                      //2-Status abd date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text('[#23456]',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      //1-Icon
                      const Icon(Iconsax.calendar),
                      const SizedBox(width: AppSizes.spaceBtwItems / 2),

                      //2-Status abd date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping Date',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text('03 Nov 2024 ',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
