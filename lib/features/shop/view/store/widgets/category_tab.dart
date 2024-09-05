import 'package:e_shop/common/widgets/brands/brand_showcase.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/models/category_model.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppCategoryTab extends StatelessWidget {
  const AppCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                //Brands
                const AppBrandShowCase(
                  images: [
                    AppImages.productImage1,
                    AppImages.productImage2,
                    AppImages.productImage3
                  ],
                ),
                const AppBrandShowCase(
                  images: [
                    AppImages.productImage1,
                    AppImages.productImage2,
                    AppImages.productImage3
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                //Products
                AppSectionHeading(
                  title: 'You might Like',
                  onPressed: () {},
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                AppGridLayout(
                    itemcount: 4,
                    itemBuilder: (_, index) => const AppProductCardVertical()),
                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            ),
          ),
        ]);
  }
}
