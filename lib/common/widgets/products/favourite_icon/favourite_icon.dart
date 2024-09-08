import 'package:e_shop/common/widgets/icons/circular_icon.dart';
import 'package:e_shop/features/shop/controller/products/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppFavouriteIcon extends StatelessWidget {
  const AppFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(() => AppCircularIcon(
          icon: controller.isFavourite(productId)
              ? Iconsax.heart5
              : Iconsax.heart,
          color: controller.isFavourite(productId) ? Colors.red : null,
          onPressed: () => controller.toggleFavouriteProduct(productId),
        ));
  }
}
