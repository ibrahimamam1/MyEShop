import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/images/app_rounded_image.dart';
import 'package:e_shop/features/shop/controller/home_controller.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPromoSlider extends StatelessWidget {
  const AppPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index)),
            items:
                banners.map((url) => AppRoundedImage(imageURL: url)).toList()),
        const SizedBox(
          height: AppSizes.spaceBtwItems,
        ),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  CircularContainer(
                    width: 20,
                    height: 4,
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
  }
}
