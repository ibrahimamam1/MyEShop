import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/brands/brand_cards.dart';
import 'package:e_shop/common/widgets/products/sortable_products.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SAppBar(title: Text('Nike')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              //Brand Detail
              AppBrandCard(showBorder: true),
              SizedBox(height: AppSizes.spaceBtwSections),
              AppSortableProducts(products: [])
            ],
          ),
        ),
      ),
    );
  }
}
