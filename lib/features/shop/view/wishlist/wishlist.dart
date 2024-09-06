import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/icons/circular_icon.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/features/shop/view/home/home.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              AppGridLayout(
                  itemcount: 4,
                  itemBuilder: (_, index) => AppProductCardVertical(
                        product: ProductModel.empty(),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
