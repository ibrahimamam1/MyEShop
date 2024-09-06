import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/features/shop/view/product_details/widgets/bottom_add_to_card.dart';
import 'package:e_shop/features/shop/view/product_details/widgets/product_attributes.dart';
import 'package:e_shop/features/shop/view/product_details/widgets/product_detail_image_slider.dart';
import 'package:e_shop/features/shop/view/product_details/widgets/product_metadata.dart';
import 'package:e_shop/features/shop/view/product_details/widgets/rating_share_widget.dart';
import 'package:e_shop/features/shop/view/product_review/product_review.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //1- Product Image Slider
            const ProductImageSlider(),

            //2-Product Details
            Padding(
                padding: const EdgeInsets.only(
                    right: AppSizes.defaultSpace,
                    left: AppSizes.defaultSpace,
                    bottom: AppSizes.defaultSpace),
                child: Column(
                  children: [
                    //rating and Share
                    const AppRatingAndShare(),

                    //price , title, Stack, & brand
                    const AppProductMetaData(),

                    //Attributes
                    const AppProductAttributes(),
                    const SizedBox(height: AppSizes.spaceBtwSections),

                    //Checkout Button
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Checkout'))),

                    //Description
                    const AppSectionHeading(
                      title: 'Desscription',
                      showActionButton: false,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    const ReadMoreText(
                      'This is a product description for green nike shoes. There are some things that can added ',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show More',
                      trimExpandedText: 'Less',
                      moreStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),

                    //Reviews
                    const Divider(),
                    const SizedBox(
                      height: AppSizes.spaceBtwItems,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppSectionHeading(
                          title: 'Rviews(199)',
                          showActionButton: false,
                          onPressed: () {},
                        ),
                        IconButton(
                            onPressed: () =>
                                Get.to(() => const ProductReviewScreen()),
                            icon: const Icon(
                              Iconsax.arrow_right_3,
                              size: 18,
                            )),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
