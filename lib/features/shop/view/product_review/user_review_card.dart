import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/products/ratings/rating_stars_indicator.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage(AppImages.userProfileImage1)),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Text('random user',
                    style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),

        const SizedBox(height: AppSizes.spaceBtwItems),

        //Review
        Row(
          children: [
            const AppRatingStarsIndicator(rating: 4),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Text(
              '01 sep , 2024',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        const ReadMoreText(
          'The User interface bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ',
          trimMode: TrimMode.Line,
          trimLines: 2,
          trimExpandedText: 'Show less',
          trimCollapsedText: 'Show More',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary),
        ),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),

        //company/seller review
        AppCircularContainer(
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Random Store',
                        style: Theme.of(context).textTheme.titleMedium),
                    Text('02 sep , 2024',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                const ReadMoreText(
                  'The User interface bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ',
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  trimExpandedText: 'Show less',
                  trimCollapsedText: 'Show More',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: AppSizes.spaceBtwSections,
        )
      ],
    );
  }
}
