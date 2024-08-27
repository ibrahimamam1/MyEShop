import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppCouponCode extends StatelessWidget {
  const AppCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);
    return AppCircularContainer(
      showBorder: true,
      backgroundColor: dark ? AppColors.dark : AppColors.white,
      padding: const EdgeInsets.only(
          top: AppSizes.sm,
          bottom: AppSizes.sm,
          right: AppSizes.sm,
          left: AppSizes.sm),
      child: Row(
        children: [
          //promo coupon Text Field
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a Promo Code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          //Button
          SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: dark
                        ? AppColors.white.withOpacity(0.5)
                        : AppColors.dark.withOpacity(0.5),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    side: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: const Text('Apply')))
        ],
      ),
    );
  }
}
