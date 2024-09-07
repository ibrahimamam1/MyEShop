import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_shop/features/shop/controller/all_products/all_products-controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppSortableProducts extends StatelessWidget {
  const AppSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);

    return Column(
      children: [
        //DropDown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          items: [
            'Name',
            'higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((element) =>
                  DropdownMenuItem(value: element, child: Text(element)))
              .toList(),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        //Products
        Obx(
          () => AppGridLayout(
              itemcount: controller.products.length,
              itemBuilder: (_, index) =>
                  AppProductCardVertical(product: controller.products[index])),
        ),

        //
      ],
    );
  }
}
