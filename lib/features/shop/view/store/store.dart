import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_shop/common/widgets/images/app_circular_image.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:e_shop/common/widgets/text/brand_title_text_with_verification_icon.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/enums.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: SAppBar(
        title: Text(
          'Store',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          AppCartCounterIcon(
            onPressed: () => {},
            iconColor: dark ? AppColors.white : AppColors.black,
          )
        ],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxScrollable) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? AppColors.black : AppColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //Search Bar
                      const SizedBox(
                        height: AppSizes.spaceBtwItems,
                      ),
                      const AppSearchContainer(
                        text: 'Search In Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ),

                      //featured brands
                      AppSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwItems / 1.5,
                      ),

                      AppGridLayout(
                          itemcount: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: AppCircularContainer(
                                padding: const EdgeInsets.all(AppSizes.sm),
                                showBorder: true,
                                backgroundColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    //Icon
                                    Flexible(
                                      child: AppCircularImage(
                                        isNetworkImage: false,
                                        image: AppImages.clothIcon,
                                        backgroundColor: Colors.transparent,
                                        overlayColor: dark
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: AppSizes.spaceBtwItems / 2,
                                    ),
                                    //Text
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const AppBrandTitleTextWithVerifiedIcon(
                                            title: 'Nike',
                                            brandTextSize: TextSizes.large,
                                          ),
                                          Text(
                                            '256 products',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              )
            ];
          },
          body: Container()),
    );
  }
}
