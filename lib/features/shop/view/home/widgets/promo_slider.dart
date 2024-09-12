import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/images/app_rounded_image.dart';
import 'package:e_shop/features/shop/controller/banner_controller.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AppPromoSlider extends StatelessWidget {
  const AppPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value)
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.md)),
          ),
        );
      // No data
      if (controller.banners.isEmpty) {
        return const Center(child: Text('No Data Found!'));
      }

      return Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index)),
              items: controller.banners
                  .map((banner) => AppRoundedImage(
                        imageURL: banner.imageUrl,
                        isNetworkImage: true,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                      ))
                  .toList()),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
          Center(
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    AppCircularContainer(
                      width: 20,
                      height: 4,
                      radius: 10,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor: controller.carouselIndex.value == i
                          ? AppColors.primary
                          : AppColors.grey,
                    ),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
