import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/appBar/tabbar.dart';
import 'package:e_shop/common/widgets/brands/brand_cards.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/category_controller.dart';
import 'package:e_shop/features/shop/controller/products/brand_controller.dart';
import 'package:e_shop/features/shop/view/brands/all_brands.dart';
import 'package:e_shop/features/shop/view/brands/brand_product.dart';
import 'package:e_shop/features/shop/view/store/widgets/category_tab.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());
    final dark = AppHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: SAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            AppCartCounterIcon(
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
                          onPressed: () =>
                              Get.to(() => const AllBrandsScreen()),
                        ),
                        const SizedBox(
                          height: AppSizes.spaceBtwItems / 1.5,
                        ),

                        //Brands Grid
                        Obx(() {
                          if (brandController.isLoading.value) {
                            return const CircularProgressIndicator();
                          }

                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                                child: Text('No Data Found',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(color: Colors.white)));
                          }
                          return AppGridLayout(
                              itemcount: brandController.featuredBrands.length,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                final brand =
                                    brandController.featuredBrands[index];
                                return AppBrandCard(
                                  showBorder: true,
                                  brand: brand,
                                  onTap: () =>
                                      Get.to(() => BrandProducts(brand: brand)),
                                );
                              });
                        })
                      ],
                    ),
                  ),

                  //Horizontally Scrollable Tabs
                  bottom: AppTabBar(
                      tabs: categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList()),
                )
              ];
            },
            body: TabBarView(
                children: categories
                    .map((category) => AppCategoryTab(category: category))
                    .toList())),
      ),
    );
  }
}
