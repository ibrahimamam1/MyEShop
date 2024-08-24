import 'package:e_shop/features/shop/view/product_details/widgets/product_detail_image_slider.dart';
import 'package:e_shop/features/shop/view/product_details/widgets/product_metadata.dart';
import 'package:e_shop/features/shop/view/product_details/widgets/rating_share_widget.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //1- Product Image Slider
            ProductImageSlider(),

            //2-Product Details
            Padding(
                padding: EdgeInsets.only(
                    right: AppSizes.defaultSpace,
                    left: AppSizes.defaultSpace,
                    bottom: AppSizes.defaultSpace),
                child: Column(
                  children: [
                    //rating and Share
                    AppRatingAndShare(),

                    //price , title, Stack, & brand
                    AppProductMetaData(),

                    //Attributes

                    //Checkout Button

                    //Description

                    //Reviews
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
