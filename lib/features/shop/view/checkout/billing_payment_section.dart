import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/checkout/checkout_controller.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBillingPaymentSection extends StatelessWidget {
  const AppBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        AppSectionHeading(
          title: 'Payment method',
          buttonTittle: 'Change',
          showActionButton: true,
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              AppCircularContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? AppColors.light : AppColors.white,
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Image(
                  image:
                      AssetImage(controller.selectedPaymentMethod.value.image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        )
      ],
    );
  }
}
