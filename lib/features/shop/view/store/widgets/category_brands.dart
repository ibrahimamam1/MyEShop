import 'package:e_shop/common/widgets/brands/brand_showcase.dart';
import 'package:e_shop/features/shop/controller/products/brand_controller.dart';
import 'package:e_shop/features/shop/models/category_model.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          final widget =
              AppCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
          if (widget != null) return widget;

          //Record Found!
          final brands = snapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (_, index) {
                final brand = brands[index];
                return FutureBuilder(
                    future: controller.getBrandProducts(
                        brandId: brand.id, limit: 3),
                    builder: (context, snapshot) {
                      final shimmerLoader = Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                      final widget =
                          AppCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: shimmerLoader);

                      if (widget != null) return widget;

                      //Record found
                      final products = snapshot.data!;
                      return AppBrandShowCase(brand: brand);
                    });
              });
        });
  }
}
