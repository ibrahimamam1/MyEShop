import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/products/ratings/rating_stars_indicator.dart';
import 'package:e_shop/features/shop/view/product_review/product_overall_rating.dart';
import 'package:e_shop/features/shop/view/product_review/user_review_card.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Apbar
      appBar: const SAppBar(
        title: Text('Reveiws & Ratings'),
        showBackArrow: true,
      ),

      //body
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and revies are verified and are from people who use the same type of device that you use'),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),

              //Overall Product Rating
              const OverallProductRating(),
              const AppRatingStarsIndicator(rating: 3.5),
              Text('12,611', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),

              //User Review List
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          )),
    );
  }
}
