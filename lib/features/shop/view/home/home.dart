import 'package:e_shop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/products/product_controller.dart';
import 'package:e_shop/features/shop/view/all_products/all_products.dart';
import 'package:e_shop/features/shop/view/home/widgets/home_app_bar.dart';
import 'package:e_shop/features/shop/view/home/widgets/home_category.dart';
import 'package:e_shop/features/shop/view/home/widgets/promo_slider.dart';
import 'package:e_shop/features/shop/view/home/widgets/shimmer_loading_effect.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppPrimaryHeaderContainer(
              child: Column(children: [
                //AppBar
                HomeAppBar(),
                SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),

                //Search Bar
                AppSearchContainer(text: 'Search In store'),
                SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),

                //Categories
                AppHomeCategories(),
                SizedBox(height: AppSizes.spaceBtwSections)
              ]),
            ),

            //Body
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: Column(
                    children: [
                      //promo slider
                      const AppPromoSlider(),
                      const SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ),

                      //Popuylar Products
                      AppSectionHeading(
                        title: 'Popular Products',
                        onPressed: () => Get.to(() => AllProductsScreen(
                            title: 'Popular Products',
                            futureMethod:
                                controller.fetchAllFeaturedProducts())),
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwItems,
                      ),
                      Obx(() {
                        return AppGridLayout(
                          itemcount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => AppProductCardVertical(
                              product: controller.featuredProducts[index]),
                        );
                      }),
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
