import 'package:e_shop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/view/home/widgets/home_app_bar.dart';
import 'package:e_shop/features/shop/view/home/widgets/home_category.dart';
import 'package:e_shop/features/shop/view/home/widgets/promo_slider.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      const AppPromoSlider(
                        banners: [
                          AppImages.promoBanner1,
                          AppImages.promoBanner2,
                          AppImages.promoBanner3,
                          AppImages.promoBanner4
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ),

                      //Popuylar Products
                      AppSectionHeading(
                        title: 'Popular Products',
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwItems,
                      ),
                      AppGridLayout(
                        itemcount: 4,
                        itemBuilder: (_, index) =>
                            const AppProductCardVertical(),
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
