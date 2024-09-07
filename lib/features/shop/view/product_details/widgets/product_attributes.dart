import 'package:e_shop/common/widgets/chips/choice_chips.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_price.dart';
import 'package:e_shop/common/widgets/text/product_title_text.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/products/variation_controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppProductAttributes extends StatelessWidget {
  AppProductAttributes({super.key, required this.product});

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(children: [
        if (controller.selectedVariation.value.id.isNotEmpty)
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
                          if (controller.selectedVariation.value.salePrice > 0)
                            Text(
                              '\$${controller.selectedVariation.value.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      decoration: TextDecoration.lineThrough),
                            ),
                          const SizedBox(
                            width: AppSizes.spaceBtwItems,
                          ),

                          //sale Price
                          AppProductPrice(
                              price: controller.getVariationPrice()),
                        ]),

                        //Stock Status
                        Row(
                          children: [
                            const AppProductTitleText(
                              title: 'Stock : ',
                              smallSize: true,
                            ),
                            Text(
                              controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),

                //Variation Description
                AppProductTitleText(
                  title: controller.selectedVariation.value.description ?? '',
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
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSectionHeading(
                          title: attribute.name ?? '',
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: AppSizes.spaceBtwItems / 2,
                        ),
                        Obx(
                          () => Wrap(
                              spacing: 8,
                              children: attribute.values!.map((value) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    value;
                                final available = controller
                                    .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(value);
                                return AppChoiceChip(
                                  text: value,
                                  selected: isSelected,
                                  onSelected: available
                                      ? (selected) {
                                          if (selected && available) {
                                            controller.onAttributesSelected(
                                                product,
                                                attribute.name ?? '',
                                                value);
                                          }
                                        }
                                      : null,
                                );
                              }).toList()),
                        )
                      ]),
                )
                .toList()),
      ]),
    );
  }
}
