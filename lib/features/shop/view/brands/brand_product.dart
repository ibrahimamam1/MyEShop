import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/brands/brand_cards.dart';
import 'package:e_shop/common/widgets/products/sortable_products.dart';
import 'package:e_shop/features/shop/controller/products/brand_controller.dart';
import 'package:e_shop/features/shop/models/brand_model.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: SAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              //Brand Detail
              AppBrandCard(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    //TODO: ADD LOADER
                    final widget =
                        AppCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot);
                    if (widget != null) return widget;

                    //othewise data found
                    final brandProducts = snapshot.data!;
                    return AppSortableProducts(products: brandProducts);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
