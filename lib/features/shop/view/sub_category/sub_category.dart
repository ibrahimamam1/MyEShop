import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/images/app_rounded_image.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_cart_horizontal.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(
        title: Text('Sports Shirt'),
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
              Column(
                children: [
                  //Heading
                  AppSectionHeading(title: 'Sports shirts', onPressed: () {}),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          const AppProductCardHorizontal(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: AppSizes.spaceBtwItems),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
