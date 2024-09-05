import 'package:e_shop/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/category_controller.dart';
import 'package:e_shop/features/shop/view/home/widgets/shimmer_loading_effect.dart';
import 'package:e_shop/features/shop/view/sub_category/sub_category.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHomeCategories extends StatelessWidget {
  const AppHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.defaultSpace),
      child: Column(
        children: [
          const AppSectionHeading(
            title: 'Popular Categories',
            showActionButton: false,
            textColor: AppColors.white,
          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
          Obx(() {
            if (categoryController.isLoading.value) {
              return const ShimmerLoadingEffect();
            }
            if (categoryController.featuredCategories.isEmpty) {
              return Center(
                  child: Text('No data Found',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white)));
            }
            return SizedBox(
              height: 80,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categoryController.featuredCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final category =
                        categoryController.featuredCategories[index];
                    return AppVerticalImageText(
                      image: category.image,
                      title: category.name,
                      onTap: () => Get.to(() => const SubCategoriesScreen()),
                    );
                  }),
            );
          })
        ],
      ),
    );
  }
}
