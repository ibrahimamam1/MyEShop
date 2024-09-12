import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/layouts/grid_layout.dart';
import 'package:e_shop/common/widgets/products/sortable_products.dart';
import 'package:e_shop/features/shop/controller/all_products/all_products-controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
              final shimmerLoader = Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: AppGridLayout(
                  itemcount: 4, // Adjust the number of shimmer items as needed
                  itemBuilder: (_, __) => Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );

              final widget = AppCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot, loader: shimmerLoader);

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
