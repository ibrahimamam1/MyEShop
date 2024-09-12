import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/icons/circular_icon.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_shop/features/shop/controller/products/favourites_controller.dart';
import 'package:e_shop/features/shop/view/home/home.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Scaffold(
      appBar: SAppBar(
        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          AppCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    future: controller.fetchFavoriteProductsFromDatabase(),
                    builder: (context, snapshot) {
                      // Shimmer loader effect
                      final shimmerLoader = Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: AppGridLayout(
                          itemcount:
                              4, // Adjust the number of shimmer items as needed
                          itemBuilder: (_, __) => Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );

                      final widget =
                          AppCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: shimmerLoader);

                      if (widget != null) return widget;

                      //otherwise data found
                      final products = snapshot.data!;
                      return AppGridLayout(
                          itemcount: products.length,
                          itemBuilder: (_, index) => AppProductCardVertical(
                                product: products[index],
                              ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
