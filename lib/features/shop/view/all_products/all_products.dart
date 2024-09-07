import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/products/sortable_products.dart';
import 'package:e_shop/features/shop/controller/all_products/all_products-controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: SAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchproductByQuery(query),
            builder: (context, snapshot) {
              //TODO : Add a loader effect like a shimmer Effect

              final widget = AppCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot);

              if (widget != null) return widget;
              //otherwise products have been found
              final products = snapshot.data!;
              return AppSortableProducts(
                products: products,
              );
            },
          ),
        ),
      ),
    );
  }
}
