import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(
        title: Text('All Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              //DropDown
              DropdownButtonFormField(
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                  items: [
                    'Name',
                    'higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popularity'
                  ]
                      .map((element) => DropdownMenuItem(
                          value: element, child: Text(element)))
                      .toList(),
                  onChanged: (value) {}),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Products
              AppGridLayout(
                  itemcount: 10,
                  itemBuilder: (_, index) => const AppProductCardVertical()),

              //
            ],
          ),
        ),
      ),
    );
  }
}
