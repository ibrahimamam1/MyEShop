import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/images/app_rounded_image.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_cart_horizontal.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/category_controller.dart';
import 'package:e_shop/features/shop/models/category_model.dart';
import 'package:e_shop/features/shop/view/all_products/all_products.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: SAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              //Banner
              const AppRoundedImage(
                imageURL: AppImages.promoBanner4,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Sub Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    //TODO: Add Appropriate Loader
                    final widget =
                        AppCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot);

                    if (widget != null) return widget;

                    //otherwise data found
                    final subcategories = snapshot.data!;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subcategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subcategory = subcategories[index];

                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subcategory.id),
                              builder: (context, snapshot) {
                                //TODO: Add Appropriate Loader
                                final widget = AppCloudHelperFunctions
                                    .checkMultiRecordState(snapshot: snapshot);

                                if (widget != null) return widget;

                                //otherwise data found
                                final products = snapshot.data!;
                                return Column(children: [
                                  //Heading
                                  AppSectionHeading(
                                      title: subcategory.name,
                                      onPressed: () => AllProductsScreen(
                                            title: subcategory.name,
                                            futureMethod:
                                                controller.getCategoryProducts(
                                                    categoryId: subcategory.id,
                                                    limit: -1),
                                          )),
                                  const SizedBox(
                                      height: AppSizes.spaceBtwItems / 2),

                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                      itemCount: products.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          AppProductCardHorizontal(
                                              product: products[index]),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                              width: AppSizes.spaceBtwItems),
                                    ),
                                  ),

                                  const SizedBox(height: AppSizes.spaceBtwSections)
                                ]);
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
