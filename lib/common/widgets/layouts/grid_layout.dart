import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppGridLayout extends StatelessWidget {
  const AppGridLayout({
    super.key,
    required this.itemcount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
  });

  final int itemcount;
  final double?
      mainAxisExtent; //how many items nmaximum can be aligned vertically
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemcount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: mainAxisExtent,
          mainAxisSpacing: AppSizes.gridViewSpacing,
          crossAxisSpacing: AppSizes.gridViewSpacing,
        ),
        itemBuilder: itemBuilder);
  }
}
