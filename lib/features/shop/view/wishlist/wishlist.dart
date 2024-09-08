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
                      //Todo : Add Appropriate Loader
                      final widget =
                          AppCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot);

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
