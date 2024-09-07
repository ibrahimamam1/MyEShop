import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:e_shop/common/widgets/icons/circular_icon.dart';
import 'package:e_shop/common/widgets/images/app_rounded_image.dart';
import 'package:e_shop/features/shop/controller/products/images_controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductImageSlider extends StatelessWidget {
  ProductImageSlider({super.key, required this.product});

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return AppCurveEdgeWidget(
      child: Container(
        color: dark ? AppColors.darkerGrey : AppColors.light,
        child: Stack(
          children: [
            //Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                  padding:
                      const EdgeInsets.all(AppSizes.productImageRadius * 2),
                  child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                          imageUrl: controller.selectedProductImage.value,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: AppColors.primary)),
                    );
                  }))),
            ),

            //Image Slider
            Positioned(
                right: 0,
                bottom: 30,
                left: AppSizes.defaultSpace,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSizes.spaceBtwItems),
                    itemCount: images.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Obx(() {
                      final imageSelected =
                          controller.selectedProductImage.value ==
                              images[index];
                      return AppRoundedImage(
                          isNetworkImage: true,
                          onPressed: () => controller
                              .selectedProductImage.value = images[index],
                          width: 80,
                          backgroundColor:
                              dark ? AppColors.dark : AppColors.white,
                          border: Border.all(
                              color: imageSelected
                                  ? AppColors.primary
                                  : Colors.transparent),
                          padding: const EdgeInsets.all(AppSizes.sm),
                          imageURL: images[index]);
                    }),
                  ),
                )),

            //AppBar Icons
            const SAppBar(
              showBackArrow: true,
              actions: [
                AppCircularIcon(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
