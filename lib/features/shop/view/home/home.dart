import 'package:e_shop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/search_container.dart';
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
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppPrimaryHeaderContainer(
              child: Column(children: [
                //AppBar
                HomeAppBar(),
                SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),

                //Search Bar
                SearchContainer(text: 'Search In store'),
                SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),

                //Categories
                AppHomeCategories(),
              ]),
            ),

            //Body
            Padding(
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              child: AppPromoSlider(
                banners: [
                  AppImages.promoBanner1,
                  AppImages.promoBanner2,
                  AppImages.promoBanner3,
                  AppImages.promoBanner4
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
