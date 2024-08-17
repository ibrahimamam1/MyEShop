import 'package:e_shop/common/styles/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/styles/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppPrimaryHeaderContainer extends StatelessWidget {
  const AppPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurveEdgeWidget(
      child: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              const Positioned(
                  top: -150,
                  right: -250,
                  child: CircularContainer(
                    backgroundColor: AppColors.textWhite,
                  )),
              const Positioned(
                  top: 100,
                  right: -300,
                  child: CircularContainer(
                    backgroundColor: AppColors.textWhite,
                  )),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
