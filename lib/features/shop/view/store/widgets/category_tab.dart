import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/category_controller.dart';
import 'package:e_shop/features/shop/models/category_model.dart';
import 'package:e_shop/features/shop/view/all_products/all_products.dart';
import 'package:e_shop/features/shop/view/store/widgets/category_brands.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCategoryTab extends StatelessWidget {
  const AppCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                //Brands
                CategoryBrands(category: category),
                const SizedBox(height: AppSizes.spaceBtwItems),

                //Products
                FutureBuilder(
                    future:
                        controller.getCategoryProducts(categoryId: category.id),
                    builder: (context, snapshot) {
                      //Todo : Add Appropriate Loader
                      final widget =
                          AppCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot);

                      if (widget != null) return widget;

                      //data found
                      final products = snapshot.data!;
                      return Column(
                        children: [
                          AppSectionHeading(
                            title: 'You might Like',
                            onPressed: () => Get.to(AllProductsScreen(
                                title: category.name,
                                futureMethod: controller.getCategoryProducts(
                                    categoryId: category.id, limit: -1))),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems),
                          AppGridLayout(
                              itemcount: products.length,
                              itemBuilder: (_, index) => AppProductCardVertical(
                                  product: products[index])),
                        ],
                      );
                    }),

                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            ),
          ),
        ]);
  }
}
