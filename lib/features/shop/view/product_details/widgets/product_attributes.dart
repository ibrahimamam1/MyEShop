import 'package:e_shop/common/widgets/chips/choice_chips.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_price.dart';
import 'package:e_shop/common/widgets/text/product_title_text.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppProductAttributes extends StatelessWidget {
  const AppProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(children: [
      AppCircularContainer(
        padding: const EdgeInsets.all(AppSizes.md),
        backgroundColor: dark ? AppColors.darkerGrey : AppColors.grey,
        child: Column(
          children: [
            //Title, Price amd Stock Status
            Row(
              children: [
                const AppSectionHeading(
                  title: 'Variation',
                  showActionButton: false,
                ),
                const SizedBox(
                  width: AppSizes.spaceBtwItems,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const AppProductTitleText(
                        title: 'Price',
                        smallSize: true,
                      ),
                      const SizedBox(
                        width: AppSizes.spaceBtwItems,
                      ),

                      //actual price
                      Text(
                        '\$24',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(
                        width: AppSizes.spaceBtwItems,
                      ),

                      //sale Price
                      const AppProductPrice(price: '20'),
                    ]),

                    //Stock Status
                    Row(
                      children: [
                        const AppProductTitleText(
                          title: 'Stock : ',
                          smallSize: true,
                        ),
                        Text(
                          'In Stock',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

            //Variation Description
            const AppProductTitleText(
              title:
                  'This is the description of the product and it can go up to max 4 lines',
              smallSize: true,
              maxLines: 4,
            ),
          ],
        ),
      ),
      const SizedBox(
        height: AppSizes.spaceBtwItems,
      ),

      //Attribute
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeading(
            title: 'Colors',
            showActionButton: false,
          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems / 2,
          ),
          Wrap(spacing: 8, children: [
            AppChoiceChip(
              text: 'Green',
              selected: true,
              onSelected: (value) {},
            ),
            AppChoiceChip(
              text: 'Blue',
              selected: false,
              onSelected: (value) {},
            ),
            AppChoiceChip(
              text: 'Yellow',
              selected: false,
              onSelected: (value) {},
            )
          ])
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeading(title: 'Size'),
          const SizedBox(
            height: AppSizes.spaceBtwItems / 2,
          ),
          Wrap(spacing: 8, children: [
            AppChoiceChip(
              text: 'EU 42',
              selected: true,
              onSelected: (value) {},
            ),
            AppChoiceChip(
              text: 'EU 43',
              selected: false,
              onSelected: (value) {},
            ),
            AppChoiceChip(
              text: 'EU 44',
              selected: false,
              onSelected: (value) {},
            )
          ])
        ],
      )
    ]);
  }
}
