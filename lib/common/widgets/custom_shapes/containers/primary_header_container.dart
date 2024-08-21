import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
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
              Positioned(
                  top: -150,
                  right: -250,
                  child: AppCircularContainer(
                    height: 480,
                    width: 480,
                    radius: 480,
                    backgroundColor: AppColors.textWhite.withOpacity(0.1),
                  )),
              Positioned(
                  top: 100,
                  right: -300,
                  child: AppCircularContainer(
                    height: 480,
                    width: 480,
                    radius: 480,
                    backgroundColor: AppColors.textWhite.withOpacity(0.1),
                  )),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
