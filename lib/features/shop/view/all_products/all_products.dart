import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/products/sortable_products.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SAppBar(
        title: Text('All Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: AppSortableProducts(),
        ),
      ),
    );
  }
}
