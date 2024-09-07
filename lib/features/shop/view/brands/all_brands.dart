import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/brands/brand_cards.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/products/brand_controller.dart';
import 'package:e_shop/features/shop/view/brands/brand_product.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const SAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              //Heading
              const AppSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              //Brands
              //Brands Grid
              Obx(() {
                if (brandController.isLoading.value) {
                  return const CircularProgressIndicator();
                }

                if (brandController.allBrands.isEmpty) {
                  return Center(
                      child: Text('No Data Found',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: Colors.white)));
                }
                return AppGridLayout(
                    itemcount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.featuredBrands[index];
                      return AppBrandCard(
                          showBorder: true,
                          brand: brand,
                          onTap: () =>
                              Get.to(() => BrandProducts(brand: brand)));
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
